import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
// import 'package:share_plus/share_plus.dart';


class UserProfilePage extends StatelessWidget {
  final Map user;

  const UserProfilePage({super.key, required this.user});

  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/users/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }
  //
  // void shareDetails(){
  //   final String details = 'Check out this Github User:\n\n '
  //       'Name: ${userDetails['login']}'
  //       'Email: ${userDetails['email']}'
  //       'Followers: ${userDetails['followers']}'
  //
  //       Share.share(details);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserDetails(user['login']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return

            Scaffold(
            appBar: AppBar(
              title: Text(user['login']),
              backgroundColor: Colors.black12,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(user['login']),
              backgroundColor: Colors.black12,
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(user['login']),
              backgroundColor: Colors.black12,
            ),
            body: const Center(
              child: Text('No data found'),
            ),
          );
        } else {
          final userDetails = snapshot.data!;
          return Scaffold(
            appBar: AppBar(

              title: Text(userDetails['login']),
              backgroundColor: Colors.black12,

                actions: [
                  IconButton(icon: const Icon(Icons.share),
                  onPressed: (){
                      Share.share(userDetails['html_url']);
                  },
                  ),
                ],
            ),
            body: Center(
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(

                    child: Container(
                      color: Colors.pinkAccent,
                      // width: double.infinity,
                      child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(userDetails['avatar_url'], fit: BoxFit.cover),
                    ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userDetails['login']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                     '${userDetails['location']}',
                    style: const TextStyle(fontSize: 16 , ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${userDetails['email']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Type: ${userDetails['type']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Profile URL: ${userDetails['html_url']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Followers: ${userDetails['followers']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Following: ${userDetails['following']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Public Repos: ${userDetails['public_repos']}',
                    style: const TextStyle(fontSize: 16),
                  ),

                ],
              ),
            ),
        ),
          );
        }
      },
    );
  }
}
