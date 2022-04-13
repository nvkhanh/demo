import 'dart:convert';

import 'package:demo_bloc_marketplace/models/auth.dart';
import 'package:demo_bloc_marketplace/utils/HttpException.dart';
import 'package:demo_bloc_marketplace/utils/api.dart';
import 'package:demo_bloc_marketplace/shared/base_repository.dart';

class LoginRepository extends BaseRepository {
  LoginRepository();

  Future<Auth> login(String username, String password) async {
    final response = await client.post(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.LOGIN),
        body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw HttpException("Username or password is incorrect");
    }
    throw HttpException("An error occurred while connecting to server");
  }
}
