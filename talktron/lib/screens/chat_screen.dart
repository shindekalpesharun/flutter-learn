import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talktron/providers/core.dart';
import 'package:talktron/providers/login_providers.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String id2;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.id2,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("${widget.userId}"),
        title: FutureBuilder(
          future: getSingleUser(widget.userId),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return Text("");
            }
            return Text(snapshot.data!['displayName']);
          },
        ),
        elevation: 5,
        leading: BackButton(onPressed: () {
          Navigator.of(context).maybePop();
        }),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('conversations')
                  .doc(getUserCompareString(widget.userId))
                  .collection("messages")
                  .orderBy("lastMessageTimestamp", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }if(!snapshot.hasData){
                  return Container();
                }
                if (snapshot.hasData) {
                  return ListView(
                    reverse: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          // currentUserOrNot(data['senderId']);
                        },
                        child: ListTile(
                          title: Text(data['lastMessage'],
                              textAlign: authUserOrNot(data['senderId'])
                                  ? TextAlign.right
                                  : TextAlign.left),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Text("Loading");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    autocorrect: true,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: "type",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      print(DateTime.now());
                      sendMessage(widget.userId, messageController.text);
                      messageController.clear();
                    },
                    icon: const Icon(Icons.send),
                    tooltip: "Send",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
