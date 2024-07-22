import 'package:flutter/material.dart';



Widget ProfileImageWidget(userProfileProvider) => CircleAvatar(

  backgroundColor: Colors.grey.shade800,
  backgroundImage: NetworkImage(userProfileProvider.users.avatar_url ?? "empty"),
);