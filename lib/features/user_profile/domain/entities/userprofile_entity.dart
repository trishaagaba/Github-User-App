//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable{
  //define the Objects we need
  final String ? name;
  final String ? url;
  final String ? type;
  final int ? public_repos;
  final String ? avatarUrl;
  final int ? followers;
  final String ? email;
  final int ? following;
  final String ? bio;

  //define the constructor of  the class with these fields
const UserProfileEntity({
  this.avatarUrl,
  this.url,
  this.type,
  this.public_repos,
  this.followers,
  this.email,
  this.following,
  this.name,
  this.bio

});

  @override
  List<Object?> get props {
    //decides wc objects we should consider for comparison
    return [
      name,
      avatarUrl,
      url,
      bio,
      email,
      following,
      followers
    ];
  }
}