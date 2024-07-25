import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget connectivityWidget(context){
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
                    content: const Text("Please check your internet settings."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          openSettings();
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

void openSettings() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.version.sdkInt >= 21) {
    await launch('android.settings.SETTINGS');
  } else {
    throw 'Device does not support settings navigation';
  }
}
