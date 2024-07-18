import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import "screens/splash.dart";


void main() {
  runApp(
    MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context)=> UserProvider(),),
       ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: 'Splash Screen',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),

    home: const WelcomePage()
    );
  }
}

