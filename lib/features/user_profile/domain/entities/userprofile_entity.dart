//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable{
  //define the Objects we need
  final String ? login;
  final String ? url;
  final String ? avatar_url;
  final int ? followers;
  final int ? following;
  final String ? bio;

  //define the constructor of  the class with these fields
const UserProfileEntity({
  this.avatar_url,
  this.url,
  this.followers,
  this.following,
  this.login,
  this.bio

});

  @override
  List<Object?> get props {
    //decides wc objects we should consider for comparison
    return [
      login,
      avatar_url,
      url,
      following,
      followers
    ];
  }
}