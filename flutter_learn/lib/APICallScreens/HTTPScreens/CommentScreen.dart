import 'package:flutter/material.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/API.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/model/Comment.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  Future<List<Comments>>? commentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextButton(
            onPressed: () => setState(() {
                  commentModel = fetchComment();
                }),
            child: Text("load to data")),
        FutureBuilder<List<Comments>>(
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text("error");
            return Flexible(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data?[index].postId.toString() ?? ""),
                  );
                },
                itemCount: snapshot.data?.length ?? 0,
              ),
            );
          },
          future: commentModel,
        )
      ]),
    );
  }
}
