import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:git_user_app/features/user_profile/presentation/providers/user_profile_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../user_profile/presentation/screens/user_profile_page.dart';
import '../widget/filter_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState ();
}

class _HomePageState  extends State<HomePage>{
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static const double _scrollThreshold = 100.0;


   bool hasSearched = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUsers('','', 0, 20);
    },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);


        if (!userProvider.isLoading && userProvider.hasMore) {
          // Increment page and fetch more users
          userProvider.fetchUsers(_controller.text,'', ++_page, 20);
        }
      }
    });
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
  final userProfileProvider = Provider.of<UserProfileProvider>(context);

  final connectivityProvider = Provider.of<ConnectivityProvider>(context);

  if(!connectivityProvider.isConnected) {
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
                  color: Color(0xFFF380E2),
                    fontSize: 24.0,fontWeight: FontWeight.bold,
                    )
              , ),
        ),

              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children:[
                    Expanded(
                      child: TextField(
                        decoration:
                                        const InputDecoration(labelText: 'Search by location',
                      border: OutlineInputBorder()),
                        onSubmitted: (value){
                      userProvider.setLocation(value);
                        }
                                        ),
                    ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
                decoration:
                const InputDecoration(labelText: 'Search by name',
                    border: OutlineInputBorder()),
                onSubmitted: (value){
                  userProvider.setName(value);
                }
            ),
          ),
                ]
                  )
              ),
                TextButton(onPressed: _clearFiltersAndSearch,
                    child: const Text("CLEAR", style: TextStyle(color: Colors.grey),)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                  // child: userProvider.isLoading && userProvider.hasMore
                  //     ? const Center(child: CircularProgressIndicator()):
                  child: userProvider.isLoading && userProvider.hasMore
                      ? const Center(child: CircularProgressIndicator(),)
                     :userProvider.hasSearched || userProvider.users.isNotEmpty ?
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
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: GestureDetector(
                                onTap: () async {
                                  final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
                                  await userProfileProvider.fetchUserProfile(userProvider.users[index].name ?? '');
                                  if (userProfileProvider.user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserProfilePage(user: userProfileProvider.user!),
                                      ),
                                    );
                                  } else {
                                    // Handle the case where the user profile is null
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Failed to load user profile'),
                                        )
                                    ); }
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
                          )
                              );
                      })
                      : const Center(child: Text("Welcome to the GitHub Users App "
                      "where you can search and get in touch with thousands of Users"
                      " for possible collaboration and inspiration.", textAlign: TextAlign.center,))
            )
    )
          ],
        ),
        )

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

void openSettings() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.version.sdkInt >= 21) {
    await launch('android.settings.SETTINGS');
  } else {
    throw 'Device does not support settings navigation';
  }
}



