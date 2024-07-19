import 'package:http/http.dart' as http;
import 'dart:convert';

class DataSource {
  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/users/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}