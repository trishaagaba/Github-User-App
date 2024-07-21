// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../widget/appbar_widget.dart';
// // import 'package:share_plus/share_plus.dart';
//
// class UserProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//   }
//   // final userdetailsusecame
// }
//   final Map user;
//
//   void _launchURL(String url) async {
//     if (await canLaunchUrl(url as Uri)) {
//       await launchUrl(url as Uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   const UserProfilePage({super.key, required this.user});
//
//   Future<Map<String, dynamic>> fetchUserDetails(String username) async {
//     final response =
//         await http.get(Uri.parse('https://api.github.com/users/$username'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load user details');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchUserDetails(user['login']),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(user['login']),
//               backgroundColor: Colors.black12,
//             ),
//             body: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             appBar: buildAppbar(context),
//             body: Center(
//               child: Text('Error: ${snapshot.error}'),
//             ),
//           );
//         } else if (!snapshot.hasData) {
//           return Scaffold(
//             appBar: buildAppbar(context),
//             body: const Center(
//               child: Text('No data found'),
//             ),
//           );
//         } else {
//           //IF THE DATA WORKS
//           final userDetails = snapshot.data!;
//           return Scaffold(
//             appBar: buildAppbar(context),
//              body:
//                  ListView(
//                    physics: ,
//                  )
//
//             Column(
//                  children: [
//                     Container(
//                       color: Colors.pink[100],
//                       width: double.infinity,
//                       height: 150.0,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const SizedBox(height: 10),
//                           CircleAvatar(
//                             backgroundImage:NetworkImage(userDetails['avatar_url'],
//                              ),
//                         ),
//                             const SizedBox(height: 10),
//                             Text(
//                               '${userDetails['login']}',
//                               style: const TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 10),
//
//                             Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text('${userDetails['followers']}',style: const TextStyle(fontWeight: FontWeight.bold),),
//                                     const Text("Followers")
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text('${userDetails['following']}',style: const TextStyle(fontWeight: FontWeight.bold)),
//                                     const Text("Following")
//                                   ],
//                                 ),]
//
//                                   // style: const TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             )
//                     ),
//                    const SizedBox(height: 10),
//                    Text(
//                      '${userDetails['location']}',
//                      style: const TextStyle(
//                        fontSize: 16,
//                      ),
//                    ),
//
//                    Text(
//                      '${userDetails['bio']}',
//                      style: const TextStyle(
//                          fontSize: 20, fontWeight: FontWeight.bold),
//                    ),
//                    const SizedBox(height: 10),
//                    Text(
//                      'Email Address ${userDetails['email']}',
//                      style: const TextStyle(fontSize: 16),
//                    ),
//                    const SizedBox(height: 10),
//                    Text(
//                      'Public Repos: ${userDetails['public_repos']}',
//                      style: const TextStyle(fontSize: 16),
//                    ),
//                    const SizedBox(height: 10),
//
//                    Text(
//                      'Type: ${userDetails['type']}',
//                      style: const TextStyle(fontSize: 16),
//                    ),
//                    GestureDetector(
//                      onTap: () => _launchURL(userDetails['html_url']),
//                      child: Text(
//                        'Profile URL: ${userDetails['html_url']}',
//                        style: const TextStyle(
//                          fontSize: 16,
//                          color: Colors.blue, // Makes it look like a link
//                          decoration: TextDecoration.underline, // Underline to look like a link
//                        ),
//                      ),
//                    ),
//
//
//                  ]
//             ),
//           );
//               // ),
//             // ),
//
//         }
//       },
//
//
//     );
//   }
//
