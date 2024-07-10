import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user_model.dart';

class UserService {
  final String apiUrl = 'https://api.github.com/users/';

  Future<User> fetchUser(String username) async {
    final response = await http.get(Uri.parse('$apiUrl$username'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
