import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/userprofile_entity.dart';

Widget buildContent(UserProfileEntity user) =>
    Container(
      // color: Colors.grey,
      child: Column(
        children: [
      Padding(padding: const EdgeInsets.only(top: 0, bottom:0.0, left: 10, right: 10), child:
      Text("${user.name}",
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
      ),
          Text("${user.email}",
            style: const TextStyle(fontSize: 28),),
        Container(
      color: const Color(0xFFF380E2),
      width: double.infinity,
      // elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
              Column(
                 children: [
                    Text('${user.followers}',style: const TextStyle(fontWeight: FontWeight.bold),),
                         const Text("Followers")
                    ],
             ),
             // const SizedBox(width: 12),
             Column(
                 children: [
                     Text('${user.following}',style: const TextStyle(fontWeight: FontWeight.bold)),
                       const Text("Following")
             ],
            ),
             Column(
               children: [
                 Text('${user.public_repos}',style: const TextStyle(fontWeight: FontWeight.bold),),
                 const Text("Repositories")
               ],
             ),
             // const SizedBox(width: 12),
           ]),
      ),
        ),
      const SizedBox(width: 8),
      const Text("Bio"),
      Center(
        child: Text(user.bio ?? "No bio",style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
      ),

      const SizedBox(height: 4),
      const Divider(),
      const SizedBox(height: 4),
      GestureDetector(
          onTap: () => _launchURL(user.url ?? "No Url"),
          child: Text(
            '${user.url}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue, // Makes it look like a link
              decoration: TextDecoration.underline, // Underline to look like a link
            ),
          )),



        ],
      ),
    );

void _launchURL(String url) async {
  if (await canLaunchUrl(url as Uri)) {
    await launchUrl(url as Uri);
  } else {
    throw 'Could not launch $url';
  }
}



