import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talktron/providers/chat_list_provider.dart';
import 'package:talktron/providers/core.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    check();
    super.initState();
  }

  check() async {
    await checkContactAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Talk Tron"),
        elevation: 10,
        actions: [
          GestureDetector(
            onTap: () {
              context.push('/profile');
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser!.photoURL.toString(),
              ),
            ),
          ),
          SizedBox(width: 8)
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('conversations')
            .where("members",
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Text("Loading");
          // }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Friends found"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return FutureBuilder(
                future: getSingleUser(
                    getCurrentUserFromList(snapshot.data!.docs[0]['members'])),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  // if (userSnapshot.connectionState == ConnectionState.waiting) {
                  //   return const Text("Loading");
                  // }
                  if (!userSnapshot.hasData) {
                    return Center(child: Text("No Friends found"));
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        userSnapshot.data!['profilePicture'],
                      ),
                    ),
                    title: Text(
                      userSnapshot.data!['displayName'],
                      textScaleFactor: 1.2,
                    ),
                    trailing: Icon(Icons.done),
                    subtitle: Text("Last Message"),
                    selected: true,
                    onTap: () async {
                      context.pushNamed('chat', params: {
                        'userId': getCurrentUserFromList(
                            snapshot.data!.docs[0]['members']),
                        'id2': '6456546'
                      });
                    },
                  );
                },
              );
            },
          );
          return FutureBuilder(
            builder: (ctx, snapshot) {
              return Text(snapshot.data.toString());
            },
            future: getSingleUser(
                getCurrentUserFromList(snapshot.data!.docs[0]["members"])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
