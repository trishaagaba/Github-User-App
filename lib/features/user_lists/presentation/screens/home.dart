import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:git_user_app/features/user_profile/presentation/screens/user_profile_page.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../widget/filter_widget.dart';


class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState ();
}

class _HomePageState  extends State<HomePage>{
  final TextEditingController _controller = TextEditingController();
 // final PagingController<int, UserEntity> pagingController = PagingController(firstPageKey: 1);

  List users = [];
 //  bool hasSearched = false;
 //  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUsersByLocation('', 0);
    },
    );

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
        title: Text('No Internet Connection'),
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
                      title: Text("No Internet Connection"),
                      content: Text("Please check your internet settings."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Redirect to phone settings
                            openSettings();
                          },
                          child: Text("Settings"),
                        ),
                      ],
                    );
                  },
                );
              }
            });
          },
          child: Text('Check Connection'),
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
              height: 150,
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
            const SizedBox(height: 10.0),
             SizedBox(
              // width: MediaQuery.of(context).size.width * 0.8,//80% of screen width
              child: Row(children:[
                Expanded(child:
                TextField(
                  onSubmitted: (query){
                     Provider.of<UserProvider>(context, listen: false)
                         .fetchUsersByLocation(query, 0);


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
                           .fetchUsersByLocation(_controller.text, 0);
                    }
                      ,),
                    
                ),
              ),
                ),
              IconButton(
                icon: Icon(Icons.filter_list),
                  onPressed:(){
                    _showFilterDialog(context, (name, type,followers,following){
                      userProvider.applyFilters(name,type,followers,following);
                    });
                  }

                  , ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _clearFiltersAndSearch();
                  },
                ),]
              )
            ),
            const SizedBox(height: 10.0),
            Expanded(
                 child: userProvider.isLoading ? const Center(child: CircularProgressIndicator(),)
                     :userProvider.hasSearched && userProvider.users.isNotEmpty ?
                      listOfNames(userProvider.users)
                    :listOfNames(userProvider.users)),

          ],
        ),
      ),
    );
  }


  Widget listOfNames(List<dynamic> users){
    final userProvider = Provider.of<UserProvider>(context);
    return
         PagedListView<int, dynamic>(
           pagingController: userProvider.pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
          //itemCount: users.length,
          itemBuilder: (context,user, index){
            print("Accessing index: $index");

            if (index >= users.length) {
              return const SizedBox.shrink();
            }
        return Card(
              color: Colors.pink[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ) ,
          margin: const EdgeInsets.symmetric(vertical: 2.0 ),

          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (counter)=> UserProfilePage(user: users[index])
              ));
            },
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(users[index]['avatar_url']),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(users[index]['login']), ),
        subtitle: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(users[index]['type']),

              ),
            ),
          ),
        ));
      },
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
 return Container(
   width: MediaQuery.of(context).size.width*0.8,
     height: MediaQuery.of(context).size.height*0.8,
    child:  AlertDialog(
   title: Text('Filter Options'),
   content: FilterWidget(
   onFilterChanged: onFilterChanged,
   ),

 actions: [
   TextButton(
   onPressed: (){
   Navigator.of(context).pop();
   }, child: Text('Cancel')),


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




