import 'dart:convert';

import 'package:flutter_learn/APICallScreens/HTTPScreens/model/AlbumModel.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/model/Comment.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/model/UserModel.dart';
import 'package:http/http.dart' as http;

Future<List<Comments>> fetchComment() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    return List<Comments>.from(
        json.decode(response.body).map((x) => Comments.fromJson(x)));

    // return Comments.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<UserModel>> fetchUser() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  if (response.statusCode == 200) {
    return List<UserModel>.from(
        json.decode(response.body).map((x) => UserModel.fromJson(x)));
  } else {
    throw Exception('Failed to load User');
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
