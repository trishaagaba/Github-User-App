//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  //extends Equatable for easy value comparisons
  //define the Objects we need
  final String ? name;
  final String ? url;
  final String ? avatar_url;
  final int ? followers;
  final int ? following;
  final String ? type;
  final String ? bio;

  //define the constructor of  the class with these fields
  const UserEntity({
    this.avatar_url,
    this.url,
    this.type,
    this.followers,
    this.following,
    this.name,
    this.bio

  });

  @override
  List<Object?> get props {
    //decides wc objects we should consider for comparison
    return [
      name,
      avatar_url,
      type,
      url,
      following,
      followers
    ];
  }
}
