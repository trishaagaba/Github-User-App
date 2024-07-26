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
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            () {
          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: const Color(0xFF624C63),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/spash.png", width: 200,
                height: 200,
                color: Colors.white70,),
              // colorBlendMode: BlendMode.modulate
              const SizedBox(
                height: 40,),
              const CircularProgressIndicator(color: Colors.white70),

            ],
          )

    );
  }
}



