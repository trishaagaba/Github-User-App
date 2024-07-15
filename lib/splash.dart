import 'dart:async';

import 'package:flutter/material.dart';
import 'home.dart';

class WelcomePage extends StatefulWidget {
  // const WelcomePage({super.key});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

  class _WelcomePageState extends State <WelcomePage> {


    @override
    void initState(){
      super.initState();
      Timer(const Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>const HomePage())));
    }
  @override
  Widget build(BuildContext context) {
    return Container(

      color: const Color(0xFF2E2E2E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset("assets/githubUserBg.jpg", width: 100,height: 100,),
          const SizedBox(
            height: 60,),

          const CircularProgressIndicator(),
        ],
      )

    );
  }
}



