import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future checkContactAvailable() async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      try {
        print(documentSnapshot.get("contacts"));
      } catch (e) {
        print("contacts not found");
        await createContact();
      }
    } else {
      print('Document does not exist on the database');
    }
  });
}

Future createContact() async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  await docUser.set(
    {"contacts": []},
    SetOptions(
      merge: true,
    ),
  );
}

Future<void> getSingleUserTest(String userId)  async {
  // final ref = FirebaseFirestore.instance.collection("conversations").doc('7Bw7bS9Fg7NlvW65wc7AuG08ckg1-U9BAxjO6eIXsJRBXDWdJ3FPJatG2').collection("messages");
  // ref.add({
  //   'lastMessage':'hi how are you',
  //   'lastMessageStatus':'delivered',
  //   'lastMessageTimestamp':DateTime.now().millisecondsSinceEpoch
  // }).then((value) => print(value));
  // print()ref.doc("t"));

  // final querySnapshot = await FirebaseFirestore.instance.collection("conversations").doc("7Bw7bS9Fg7NlvW65wc7AuG08ckg1-U9BAxjO6eIXsJRBXDWdJ3FPJatG2").collection("messages");
  // querySnapshot.snapshots();

  // var data = await FirebaseFirestore.instance.collection("users").doc("7Bw7bS9Fg7NlvW65wc7AuG08ckg1").get()["displayName"];
  // print(FirebaseFirestore.instance.collection('users').snapshots().length);
  //TODO: work here
  // print(data['displayName']);
  // querySnapshot.docs

//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) async {
//     if (documentSnapshot.exists) {
//       try {
//         // return documentSnapshot.data();
//         print(documentSnapshot.get("displayName"));
//       } catch (e) {
//       }
//     } else {
//       if (kDebugMode) {
//         print('Document does not exist on the database');
//       }
//     }
//   });
}