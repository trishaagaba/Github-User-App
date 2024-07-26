import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../user_profile/presentation/providers/user_profile_provider.dart';
import '../../../user_profile/presentation/screens/user_profile_page.dart';
import '../providers/user_provider.dart';

Widget cardWidget(context, index){
  final userProvider = Provider.of<UserProvider>(context);

  return Card(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () async {
          final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
          await userProfileProvider.fetchUserProfile(userProvider.users[index].name ?? '');

          if (userProfileProvider.user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(user: userProfileProvider.user!),
              ),
            );
          } else {
            // Handle the case where the user profile is null
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to load user profile'),
                )
            ); }
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage(userProvider.users[index].avatar_url ?? 'https://via.placeholder.com/150'),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(userProvider.users[index].name ?? 'Unknown user'),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(userProvider.users[index].type ?? 'Unknown type'),
          ),
        ),
      )
  );
}