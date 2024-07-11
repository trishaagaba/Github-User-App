import 'package:flutter/material.dart';
import 'home.dart';

class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/githubImg.png"),
            ),
            // const SizedBox(height: 40),
            // const Text("Welcome",
            // style: TextStyle(
            //   color: Colors.black,
            //   fontSize: 30,fontWeight: FontWeight.bold
            // ),),
            // const Text("to",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 30,fontWeight: FontWeight.bold
            //   ),),
            const SizedBox(height: 40),
            const Text("GITHUB USERS",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,fontWeight: FontWeight.bold
              ),),
            const SizedBox(height: 360),

              // child:Align(alignment: Alignment.bottomCenter,
              ElevatedButton(
                onPressed: () {
                  context;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()),
                  );
                },
                child: const Text('Get Started')
            ),
            // const SizedBox(height: 10),
          ],
        ),
      )
    )
    );
  }


}

