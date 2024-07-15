import 'package:flutter/cupertino.dart';
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
 final ScrollController _scrollController = ScrollController();
  List _users = [];
  bool _hasSearched = false;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  

  @override
  void initState(){
    super.initState();
    //_searchUsers();
    _fetchDefaultUsers();
    
  }

  Future<void> _fetchDefaultUsers() async{
    final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:{location}"));


    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200){
      final data = json.decode(response.body);

      if (data['items'] == null || data['items'].isEmpty) {
        if (kDebugMode) {
          print("searching");
        }
      }

      setState(() {
        _users = data['items'] ?? [];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _searchUsers(String query) async {

    if (query.isEmpty){
      if (kDebugMode) {
        print('Searching');
      }
    }
    final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:$query"));
    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      // print(response);
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
      debugShowCheckedModeBanner : false,

      home: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Image.asset(
            "assets/geolocator.jpg",
            fit: BoxFit.cover, height: 150,
            width: double.infinity,),
            // const SizedBox(height: 40.0),
        Container(
          alignment: Alignment.center,
          color: const Color(0xFF2E2E2E),
          width: double.infinity,

          child : const Text('GITHUB USERS',

                style: TextStyle(
                  color: Colors.white,
                    fontSize: 24.0,fontWeight: FontWeight.bold,
                    )
              , ),
        ),
            const SizedBox(height: 20.0),
             Container(
              width: MediaQuery.of(context).size.width * 0.8,//80% of screen width
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E2E2E)),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    hintText: 'Search by location',
                    suffixIcon: IconButton( onPressed: (){
                      _searchUsers(_controller.text);
                    }, icon: const Icon(Icons.search)
                      ,),
                    
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            ElevatedButton.icon(onPressed: filterItems(), icon: const Icon(Icons.filter_list), label: const Text("Filter"),)  ,
            Expanded(
                child:Column(
                  children: [
                 _isLoading ? const Center(child: CircularProgressIndicator(),)
                     :_hasSearched && _users.isNotEmpty ? listOfNames()
                    :baseBackground()]),
    )

          ],
        ),
      ),

    );

  }
  Widget listOfNames(){
     return
    // return Column(
    // children: [
    //   const SizedBox(height: 10.0),
    //     Text("Showing results for ${_controller.text}...", style: const TextStyle(fontWeight: FontWeight.bold), ),
    //      const SizedBox(height: 10.0),
        Expanded(
        child: ListView.builder(
      // itemCount: 20, based off the list of users of every location
      itemBuilder: (context, index){
         index= _users.length;
        return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              color: Colors.pink[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ) ,
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0 ),
          

          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (counter)=> UserProfilePage(user: _users[index])
              ));
            },
            child: Container(

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
        ));
      },
        ),

        // )
    // ]
        );


  }

  Widget baseBackground(){

        // Image.asset("assets/githubUserBg");

    return ListView.builder(
      shrinkWrap: true,
      // itemCount: 20, based off the list of users of every location
      itemBuilder: (context, index){
        // index= _users.length;
        return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              color: Colors.pink[100],
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0 ),

              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (counter)=> UserProfilePage(user: _users[index])
                      ));
                },
                child: Container(

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
            ));
      },
    );
  }
  filterItems(){
    
  }

}


