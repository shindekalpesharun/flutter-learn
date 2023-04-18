import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String getUserCompareString(String userId) {
  if (FirebaseAuth.instance.currentUser!.uid.hashCode <= userId.hashCode) {
    return "${FirebaseAuth.instance.currentUser!.uid}-$userId";
  } else {
    return "$userId-${FirebaseAuth.instance.currentUser!.uid}";
  }
}

List getUserMemberList(String userId) {
  if (FirebaseAuth.instance.currentUser!.uid.hashCode <= userId.hashCode) {
    return [FirebaseAuth.instance.currentUser!.uid, userId];
  } else {
    return [userId, FirebaseAuth.instance.currentUser!.uid];
  }
}

String getCurrentUserFromList(List data) {
  data.remove(FirebaseAuth.instance.currentUser!.uid);
  return data[0];
}

Future<DocumentSnapshot> getSingleUser(String userId) async {
  var data =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();
  return data;
}

bool authUserOrNot(String senderId) {
  return senderId == FirebaseAuth.instance.currentUser!.uid;
}
