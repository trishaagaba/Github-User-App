import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_profile.dart';

class DetailsSource {
  Future<UserProfileModel> fetchUserDetails(String username) async {
    final response =
        await http.get(Uri.parse('https://api.github.com/users/$username'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserProfileModel.fromJson(data);
    } else {
      throw Exception('Failed to load users details');
    }
  }
}
