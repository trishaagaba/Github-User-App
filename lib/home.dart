import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/user_profile_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart'

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  // const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState ();
}

class _HomePageState  extends State<HomePage>{

 final TextEditingController _controller = TextEditingController();
  List _users = [];
  bool _hasSearched = false;

  // Future<void> _launchURL(String url) async{
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200){
  //
  //   }
  // }


  Future<void> _searchUsers(String query) async {

    if (query.isEmpty){
      if (kDebugMode) {
        print('Searching');
      }
    }
    final response = await http.get(Uri.parse("https://api.github.com/users/{username}"));
    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      print(response);
      setState(() {
        _users = data['items'] ?? [];
        _hasSearched = true;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Image.asset(
            "assets/geolocator.jpg", fit: BoxFit.cover, height: 200,
            width: double.infinity,),
            const SizedBox(height: 40.0),

            const Text('GITHUB USERS',
                style: TextStyle(
                    fontSize: 24.0,fontWeight: FontWeight.bold,
                    )
              , ),
            const SizedBox(height: 40.0),
            TextField(

              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                hintText: 'Search by location',
                suffixIcon: IconButton( onPressed: (){
                  _searchUsers(_controller.text);
                }, icon: const Icon(Icons.search)
                  ,)
              ),
            ),
            Expanded(
                child: _hasSearched && _users.isNotEmpty ? listOfNames()
                    : baseBackground()),


          ],
        ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.grey,
        // Color: Colors.purple[50],
          child: SizedBox(
            height: 10.0,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


              ],
            ),

      )),
      ),

    );

  }
  Widget listOfNames(){

    return ListView.builder(
      itemBuilder: (context, index){
        return MouseRegion(
          onEnter: (event){
            setState(() {
              _users[index]['isHovered'] = true;

            });
          },
          onExit: (event) {
            setState(() {
              _users[index]['isHovered'] = false;
            });
          },
          child: GestureDetector(
            onTap: () {
              // _launchURL(_users[index]['html_url']);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (counter)=> UserProfilePage(user: _users[index])
              ));
            },
            child: Container(
              color: _users[index]['isHovered'] == true ? Colors.purple[50] : Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_users[index]['avatar_url']),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(_users[index]['login']),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget baseBackground(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    );
  }

}


