import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/widget/coonectivity_widget.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:git_user_app/features/user_profile/presentation/widget/buildContent.dart';
import 'package:git_user_app/features/user_profile/presentation/widget/buildTop.dart';
import 'package:provider/provider.dart';
import '../../../user_lists/presentation/providers/connectivity_provider.dart';

class UserProfilePage extends StatelessWidget {

  final double coverHeight = 150;
  final double profileHeight = 144;

  final UserProfileEntity user;

  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    if (!connectivityProvider.isConnected) {
      return connectivityWidget(context);
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: BuildTop(user, context),
          ),
          Expanded(
            child: buildContent(user),
          ),
        ],
      ),
    );
  }

}