import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talktron/model/UserProfileModel.dart';
import 'package:talktron/providers/core.dart';

Future sendMessage(String userId, String message) async {
  final ref = FirebaseFirestore.instance
      .collection("conversations")
      .doc(getUserCompareString(userId));
  ref.set({
    'members': getUserMemberList(userId),
  }).then((value) => print("members added"));
  ref.collection("messages").add({
    'lastMessage': message,
    'lastMessageStatus': 'delivered',
    'senderId': FirebaseAuth.instance.currentUser!.uid,
    'lastMessageTimestamp': DateTime.now().millisecondsSinceEpoch
  }).then((value) => print("message added"));
}

Future createUser() async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final user = UserProfileModel(
    id: FirebaseAuth.instance.currentUser!.uid,
    displayName: FirebaseAuth.instance.currentUser!.displayName.toString(),
    profilePicture: FirebaseAuth.instance.currentUser!.photoURL.toString(),
  );
  await docUser.set(
    user.toJson(),
    SetOptions(
      merge: true,
    ),
  );
}

check_user_login(BuildContext context) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
      // Navigator.pushNamedAndRemoveUntil(
      //     context, '/chat_list_screen', (route) => false);

      context.pushReplacement('/chatlist');
    }
  });
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
