import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/widget/card_widget.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../widget/coonectivity_widget.dart';

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
          .fetchUsers('','', _page, 20);
    },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setHasMore(true);
          userProvider.fetchUsers(_controller.text,'', ++_page, 20);
      }
    });
  }
    @override
    void dispose() {
      _scrollController.dispose();
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final connectivityProvider = Provider.of<ConnectivityProvider>(context);

  if(!connectivityProvider.isConnected) {
    return connectivityWidget(context);
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
          color: const Color(0xFF35032E),
          width: double.infinity,

          child : const Text('GITHUB USERS',
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 24.0,fontWeight: FontWeight.bold,
                    )
              , ),
        ),

              Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(children:[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'Search by location',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(icon: const Icon(Icons.clear),
                        onPressed:
                          (){
                        _controller.clear();
                        } )),
                        onChanged: (value){
                      userProvider.setLocation(value);
                        },
                                        ),
                    ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
                decoration:
                InputDecoration(labelText: 'Search by name',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(icon: const Icon(Icons.clear),
                        onPressed:
                            (){
                          _controller.clear();
                        } )),
                onSubmitted: (value){
                  userProvider.setName(value);
                }
            ),
          ),
                ]
                  )
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),

                  child:
                  userProvider.isLoading
                      ? const Center(child: CircularProgressIndicator(),)
                     :userProvider.hasSearched || userProvider.users.isNotEmpty ?
                      ListView.builder(
                      controller: _scrollController,
                      itemCount: userProvider.users.length,
                      itemBuilder: (context, index) {
                        print('List length: ${userProvider.users.length}, Current index: $index');

                        return cardWidget(context, index);
                      })
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Center(child: Text("Welcome to the GitHub Users App "
                        "Users Loading",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),)),
                    SizedBox(height: 8.0),
                    CircularProgressIndicator(),
                  ],),

            )
    ),
      ],
        ),
        )

    );
  }
}



