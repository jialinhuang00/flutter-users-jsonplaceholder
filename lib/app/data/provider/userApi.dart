import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users/app/data/models/user.dart';

class UsersApi {
  Future<List<User>> getUsers() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return usersFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return [];
  }

  Future<User?> updateUser(User data) async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users/${data.id}');
    var response = await client.put(
      uri,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(response.bodyBytes);
    print(response.body);
    if (response.statusCode == 200) {
      User updatedUser = User.fromJson(json.decode(response.body));
      return updatedUser;
    }
    return null;
  }
}
