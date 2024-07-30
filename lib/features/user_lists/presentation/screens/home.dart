import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/user_provider.dart';
import 'package:git_user_app/features/user_lists/presentation/widget/card_widget.dart';
import 'package:git_user_app/features/user_lists/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../widget/coonectivity_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  static const double _scrollThreshold = 100.0;

  bool hasSearched = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<UserProvider>(context, listen: false)
            .fetchUsers('', '', _page, 20);
      },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setHasMore(true);
        userProvider.fetchUsers(_locationController.text, '', ++_page, 20);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    if (!connectivityProvider.isConnected) {
      return connectivityWidget(context);
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Column(
            children: <Widget>[
              Image.asset(
                "assets/geolocator.jpg",
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                alignment: Alignment.center,
                color: const Color(0xFF624C63),
                width: double.infinity,
                child: const Text(
                  'GITHUB USERS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            labelText: 'Search by location',
                            labelStyle: const TextStyle(fontSize: 14.0),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black38,
                                  size: 15,
                                ),
                                onPressed: () {
                                  _locationController.clear();
                                  userProvider.clearFiltersAndSearch();
                                })),
                        onSubmitted: (value) {
                          userProvider.setLocation(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: 'Search by name',
                              labelStyle: const TextStyle(fontSize: 14.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black38, size: 15),
                                  onPressed: () {
                                    _nameController.clear();
                                    userProvider.clearFiltersAndSearch();
                                  })),
                          onSubmitted: (value) {
                            userProvider.setName(value);
                          }),
                    ),
                  ])),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
                  child: userProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : userProvider.hasSearched ||
                              userProvider.users.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              itemCount: userProvider.users.length,
                              itemBuilder: (context, index) {
                                print(
                                    'List length: ${userProvider.users.length}, Current index: $index');
                                return cardWidget(context, index);
                              }
                              )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _locationController.dispose();
    _nameController.dispose();

    super.dispose();
  }
}
