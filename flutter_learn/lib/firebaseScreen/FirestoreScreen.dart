import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // final user = <String, dynamic>{
  //   "first": "Ada",
  //   "last": "Lovelace",
  //   "born": 1815
  // };

  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final db=FirebaseFirestore.instance.collection("learn").doc("hi");
              final json={
                "name":"shinde"
              };
              await db.set(json);
            },
            child: Text("Click Here"),
          ),
        ],
      ),
    );
  }
}
