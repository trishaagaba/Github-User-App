import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';

Widget connectivityWidget(context) {
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
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.SETTINGS',
    );
    await intent.launch();
  } else {
    throw 'Device does not support settings navigation';
  }
}
