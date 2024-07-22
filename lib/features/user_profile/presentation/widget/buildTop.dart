import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../domain/entities/userprofile_entity.dart';
import 'coverImage.dart';

const double coverHeight = 200;
const double profileHeight = 144;

Widget BuildTop(UserProfileEntity user, context){
  const topDist = coverHeight - profileHeight/2;
  const bottom = profileHeight/2;// radius

  return Scaffold(
      body: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [

        Container(
          margin: const EdgeInsets.only(bottom: bottom),
      child : CoverImageWidget(),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white70,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.share),
            color: Colors.white70,
            onPressed: () {
              Share.share('Check out this profile: ${user.url}');
            },
          ),
        ),
      Positioned(
      top: topDist,
      child: CircleAvatar(
      radius: profileHeight/2, //cause radius is half
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(user.avatarUrl ?? ""),
      )
      )
]
  )
  );
}