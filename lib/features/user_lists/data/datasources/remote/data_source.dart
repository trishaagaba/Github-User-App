import 'package:git_user_app/features/user_lists/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';

class DataSource {
    Future<List<dynamic>> fetchUsersByLocation(String query, int page, int pageSize) async {
    final response = await http.get(
    Uri.parse("https://api.github.com/search/users?q=location:$query&page=$page&per_page=$pageSize"));

    if(response.statusCode==200) {
      final data = json.decode(response.body);
      return (data['items']);
    }
    else{
      throw Exception('Failed to load users');
    }
  }

    // Future<Map<String, dynamic>> fetchUsers(String userUrl) async {
    //   final response = await http.get(Uri.parse(userUrl));
    //   if (response.statusCode == 200) {
    //     return json.decode(response.body) as Map<String, dynamic>;
    //   } else {
    //     throw Exception('Failed to load users');
    //   }
    // }


    Future<Map<String, dynamic>> fetchUserDetails(String username) async {
      final response = await http.get(Uri.parse('https://api.github.com/users/$username'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user details');
      }
    }

}

