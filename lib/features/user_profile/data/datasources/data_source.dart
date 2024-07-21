import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataSource {

  Future<List<UserProfileEntity>> fetchUserDetails(String username) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/users/$username'));
    if(response.statusCode==200) {
      final data = json.decode(response.body);
      return (data['items']);
    }
    else{
      throw Exception('Failed to load users details');
    }
  }
}
