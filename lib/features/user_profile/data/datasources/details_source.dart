import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/userprofile.dart';

class DetailsSource {

  Future<UserProfileModel> fetchUserDetails(String username) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/users/$username'));
    if(response.statusCode==200) {
      final data = json.decode(response.body);
        return UserProfileModel(
          name: data['name'] ?? 'N/A',
          url: data['url'] ?? 'N/A',
          type: data['type'] ?? 'N/A',
          email: data['email'] ?? 'N/A',
          bio: data['bio'] ?? 'N/A',
          location: data['location'] ?? 'N/A',
          public_repos: data['public_repos'] ?? 0,
          avatarUrl: data['avatar_url'] ?? 'https://via.placeholder.com/150',
          followers: data['followers'] ?? 0,
          following: data['following'] ?? 0,
        );
    }
    else{
      throw Exception('Failed to load users details');
    }
  }
}