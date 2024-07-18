import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State <WelcomePage> {
  @override
    void initState(){
      super.initState();
      Timer(const Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>HomePage())));
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E2E2E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/githubUserBg.png", width: 200,height: 200,),
          const SizedBox(
            height: 40,),
          const CircularProgressIndicator(),
        ],
      )
    );
  }
}



