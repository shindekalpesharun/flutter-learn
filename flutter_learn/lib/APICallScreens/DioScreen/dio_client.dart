import 'package:dio/dio.dart';
import 'package:flutter_learn/APICallScreens/DioScreen/model/UserModel.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      print('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  // Future<UserInfo?> createUser({required UserInfo userInfo}) async {
  //   UserInfo? retrievedUser;

  //   try {
  //     Response response = await _dio.post(
  //       _baseUrl + '/users',
  //       data: userInfo.toJson(),
  //     );

  //     print('User created: ${response.data}');

  //     retrievedUser = UserInfo.fromJson(response.data);
  //   } catch (e) {
  //     print('Error creating user: $e');
  //   }

  //   return retrievedUser;
  // }
}
