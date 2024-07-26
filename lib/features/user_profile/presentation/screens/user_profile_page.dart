import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/presentation/widget/coonectivity_widget.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../user_lists/presentation/providers/connectivity_provider.dart';

class UserProfilePage extends StatelessWidget {
  final UserProfileEntity user;
  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    if (!connectivityProvider.isConnected) {
      return connectivityWidget(context);
    }
    return Scaffold(
      appBar:
          AppBar(
          centerTitle: true,
          title: Text(user.name ?? "", textAlign: TextAlign.center,),
          backgroundColor: const Color(0xFFE3D8E0),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('Check out this profile: Name: ${user.name},Github link: ${user.url}, ');
              },
            ),
          ],
        ),
        body : Column(
            children: [
              Container(
                  color: const Color(0xFFE3D8E0),
                  width: double.infinity,
                  height: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      CircleAvatar(radius: 50.0,
                        backgroundImage:NetworkImage(user.avatarUrl ?? "",
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${user.name}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${user.location}',
                        style: const TextStyle(
                            fontSize: 10),
                      ),
                      const SizedBox(height: 20),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('${user.followers ?? 0}' ,style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
                                const Text("Followers",style: TextStyle(fontSize: 10 ),)
                              ],
                            ),
                            Container(
                              width: 1.0,
                                height: 50.0,
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(horizontal: 10.0)
                            ),
                            Column(
                              children: [
                                Text('${user.followers ?? 0}',style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
                                const Text("Following",style: TextStyle(fontSize: 10 ))
                              ],
                            ),
                            Container(
                                width: 1.0,
                                height: 50.0,
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(horizontal: 10.0)
                            ),
                            Column(
                              children: [
                                Text('${user.public_repos ?? 0}' ,style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
                                const Text("Public Repos", style: TextStyle(fontSize: 10 ))
                              ],
                            ),]
                      ),
                    ],
                  )
              ),
               Container(
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text("Bio",style: TextStyle(fontSize: 40 ), textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0),
                child: Text(
                  user.bio ?? "No Bio",
                  style: const TextStyle(
                      fontSize: 15, color: Colors.black87,
                      fontFamily: 'Roboto', height: 1.5),selectionColor: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (){
                  _launchUrl
                (user.url ?? "", context);
                },
                style: TextButton.styleFrom(backgroundColor: const Color(0xFF624C63)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Visit Github Profile", style: TextStyle(color: Colors.white70,),
                ),
              ),
              )],
      )
              )
      ]
        ),

    );

  }
  void _launchUrl(String url, context) async {
    final Uri uri = Uri.tryParse(url) ?? Uri.parse(""); // Try parsing the URL
    if (uri.isAbsolute) {

    try{
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print(e);
    }}else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid URL')),
      );
    }
      }
}