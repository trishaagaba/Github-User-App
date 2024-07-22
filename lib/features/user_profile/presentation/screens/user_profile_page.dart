import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:git_user_app/features/user_profile/presentation/widget/buildContent.dart';
import 'package:git_user_app/features/user_profile/presentation/widget/buildTop.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../user_lists/presentation/providers/connectivity_provider.dart';
import '../../../user_lists/presentation/screens/home.dart';
import '../providers/user_profile_provider.dart';
// import 'package:share_plus/share_plus.dart';

class UserProfilePage extends StatelessWidget {

  final double coverHeight = 150;
  final double profileHeight = 144;

  final UserProfileEntity user;

  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(
        context, listen: false);
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    final topDist = coverHeight - profileHeight / 2; // radius


    if (!connectivityProvider.isConnected) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('No Internet Connection'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Connectivity().checkConnectivity().then((result) {
                if (result == ConnectivityResult.none) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("No Internet Connection"),
                        content: const Text(
                            "Please check your internet settings."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _openSettings();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Redirect to phone settings
                              openSettings();
                            },
                            child: const Text("Settings"),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            child: const Text('Check Connection'),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(

        // padding: EdgeInsets.zero,
        // shrinkWrap: true,
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

void _openSettings() async{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.version.sdkInt >= 21){
    await launch('android.settings.SETTINGS');
  } else {
    throw 'Device does not support settings Navigation';
  }
}
