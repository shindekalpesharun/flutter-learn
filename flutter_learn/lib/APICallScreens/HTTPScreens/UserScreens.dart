import 'package:flutter/material.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/API.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/model/AlbumModel.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/model/UserModel.dart';

class UserScreens extends StatefulWidget {
  const UserScreens({Key? key}) : super(key: key);

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  Future<List<UserModel>>? userModel;
  List<UserModel>? userModelTest;

  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              // userModel = fetchUser();
              userModelTest = await fetchUser();
              setState(() {});
            },
            child: Text("Click to api call"),
          ),
          // Text(userModelTest != null ? userModelTest![0].email : ""),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Enter Title'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _futureAlbum = createAlbum(_controller.text);
                  });
                },
                child: const Text('Create Data'),
              ),
            ],
          ),
          _futureAlbum != null
              ? FutureBuilder<Album>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.title);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )
              : Container(),
          // FutureBuilder<List<UserModel>>(
          //   builder: (_, snapshot) {
          //     if (snapshot.hasError) return Text("error");
          //     return Flexible(
          //       child: ListView.builder(
          //         itemBuilder: (_, index) {
          //           return ListTile(
          //             title: Column(
          //               children: [
          //                 Text(snapshot.data?[index].name ?? ""),
          //                 Text(snapshot.data?[index].address.geo.lat ?? ""),
          //               ],
          //             ),
          //           );
          //         },
          //         itemCount: snapshot.data?.length ?? 0,
          //       ),
          //     );
          //   },
          //   future: userModel,
          // )
          userModelTest != null
              ? Flexible(
                  child: ListView.builder(
                    itemCount: userModelTest!.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Text(userModelTest![index].email),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}
