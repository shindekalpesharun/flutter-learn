import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Enter a name",
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final name = nameController.text;
              if (name.isNotEmpty) {
                createUser(name: name);
              }
              nameController.text = "";
              // FirebaseFirestore.instance.collection('users').doc().get();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something wan't wrong");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return Flexible(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: GestureDetector(
                        child: Column(
                          children: [
                            Text(data['name']),
                            Text(data["id"] ?? "Not Found")
                          ],
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(document.id)
                              .delete()
                              .then((value) => print("Delete"));
                        },
                      ),
                      // subtitle: Text(data['company']),
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future createUser({required String name}) async {
    //ref to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    // final json = {"name": name, "age": 21, "birthday": DateTime(2001, 01, 09)};

    // create a document and write data to firestore
    // await docUser.set(json);

    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 01, 09),
    );

    await docUser.set(user.toJson());
  }
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = "",
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
