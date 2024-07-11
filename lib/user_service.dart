import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> _searchUsers(String query) async {

  if (query.isEmpty){
    if (kDebugMode) {
      print('Searching');
    }
  }
  final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:{location}"));
  if (kDebugMode) {
    print(response);
  }

  if (response.statusCode == 200){
    final data = json.decode(response.body);
    print(response);
    setState(() {
      _users = data['items'] ?? [];
      _hasSearched = true;
    });
  } else {
    throw Exception('Failed to load users');
  }
}



// class UserService {
//   final String apiUrl = 'https://api.github.com/users/';
//
//   Future<User> fetchUser(String username) async {
//     final response = await http.get(Uri.parse('$apiUrl$username'));
//     if (response.statusCode == 200) {
//       return User.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load user');
//     }
//   }
// }
