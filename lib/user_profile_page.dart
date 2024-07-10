import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget{
  final Map user;

  const UserProfilePage({super.key, required this.user});

@override
Widget build(BuildContext context) {
  return
      Scaffold(
        appBar: AppBar(
          title: Text(user['login']),
          backgroundColor: Colors.black12,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(user['avatar_url'],
                      fit: BoxFit.cover),

                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Username: ${user['login']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Profile URL: ${user['html_url']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text('Followers: ${user['following']}',
              style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Public Repos: ${user['public_repos']}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
}
}