import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../widget/filter_widget.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState ();
}

class _HomePageState  extends State<HomePage>{
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static const double _scrollThreshold = 100.0;

  // List users = [];
   bool hasSearched = false;
  // bool isLoading = true;
  // final int _limit = 20;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUsers('', 0, 20);
    },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        if (!userProvider.isLoading && userProvider.hasMore) {
          // Increment page and fetch more users
          userProvider.fetchUsers(_controller.text, ++_page, 20);
        }
      }
    });
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent - _scrollThreshold) {
    //     Provider.of<UserProvider>(context, listen: false).fetchUsers(
    //         _controller.text, ++_page, 20);
    //   }
    // });
  }
    @override
    void dispose() {
      _scrollController.dispose();
      _controller.dispose();
      super.dispose();
    }


 void _clearFiltersAndSearch() {
   Provider.of<UserProvider>(context, listen: false).clearFiltersAndSearch();
 }


  @override
  Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final connectivityProvider = Provider.of<ConnectivityProvider>(context);

  if(!connectivityProvider.isConnected) {
    return Scaffold(
      appBar: AppBar(
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

    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        body: Column(
          children: <Widget> [
            Image.asset("assets/geolocator.jpg",
            fit: BoxFit.cover,
              height: 100,
            width: double.infinity,),
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
            // const SizedBox(height: 10.0),
             SizedBox(
              // width: MediaQuery.of(context).size.width * 0.8,//80% of screen width
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children:[
                Expanded(child:
                TextField(
                  onSubmitted: (query){
                     Provider.of<UserProvider>(context, listen: false)
                         .fetchUsers(query, 0,20);
                  },
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E2E2E)),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    hintText: 'Search by location',
                    suffixIcon: IconButton(
                     icon: const Icon(Icons.search), onPressed: () {
                       // _pagingController.refresh();
                       Provider.of<UserProvider>(context, listen: false)
                           .fetchUsers(_controller.text, 0, 20);
                    }
                      ,),
                    
                ),
              ),
                ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                  onPressed:(){
                    _showFilterDialog(context, (name, type,followers,following){
                      userProvider.applyFilters(name,type,followers,following);
                    });
                  }

                  , ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _clearFiltersAndSearch();
                  },
                ),]
              )
              )
            ),
            // const SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                  child: userProvider.isLoading && userProvider.hasMore
                      ? const Center(child: CircularProgressIndicator()):
                 // child: userProvider.isLoading ? const Center(child: CircularProgressIndicator(),)
                     //:userProvider.hasSearched || userProvider.users.isNotEmpty ?
                      ListView.builder(
                      controller: _scrollController,
                      itemCount: userProvider.users.length + 1 ,
                      itemBuilder: (context, index) {
                        print('List length: ${userProvider.users.length}, Current index: $index');
                        if (index == userProvider.users.length) {
                          return
                         const Center(child: CircularProgressIndicator());
                        // const SizedBox.shrink();
                        }
                        return Card(
                          color: Colors.pink[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: const EdgeInsets.symmetric(vertical: 2.0),
                          child: GestureDetector(
                            onTap: () {
                              null;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (counter) =>
                              //       UserProfilePage(user: userProvider.users[index])),
                              // );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                NetworkImage(userProvider.users[index].avatar_url ?? 'https://via.placeholder.com/150'),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(userProvider.users[index].name ?? 'Unknown user'),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(userProvider.users[index].type ?? 'Unknown type'),
                              ),
                            ),
                          ),
                        );
                      })
                      //: const Text("Oops Something went wrong")
            )
    )
          ],
        ),
        )

    );
  }

  Widget welcomeText(){
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("WELCOME TO 'GITHUB USERS'", style: TextStyle(fontWeight: FontWeight.bold ),),
        SizedBox(height: 10.0),
        Text("Get in touch with thousands of users all over the world."
            " View their URLs and get the opportunity to check their Github pages"
            " for possible collaboration and inspiration.",),


      ]
    );
  }

 void _showFilterDialog(
     BuildContext context, Function(String name, String type, int followers, int following) onFilterChanged){
 showDialog(
   context: context,
   builder: (BuildContext context) {
 return SizedBox(
   width: MediaQuery.of(context).size.width*0.8,
     height: MediaQuery.of(context).size.height*0.8,
    child:  AlertDialog(
   title: const Text('Filter Options'),
   content: FilterWidget(
   onFilterChanged: onFilterChanged,
   ),

 actions: [
   TextButton(
   onPressed: (){
   Navigator.of(context).pop();
   }, child: const Text('Cancel')),


   ],
 )
 );
 },

 );}

}



void openSettings(){
    if (Platform.isAndroid){
      ('package:android/settings');
    } else if (Platform.isMacOS){
      ('App-Prefs:root=WIFI');
    }
  }




