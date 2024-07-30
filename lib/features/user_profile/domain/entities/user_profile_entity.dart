//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String? name;
  final String? html_url;
  final int? public_repos;
  final String? type;
  final String? avatarUrl;
  final int? followers;
  final String? location;
  final String? email;
  final int? following;
  final String? bio;

  const UserProfileEntity(
      {this.avatarUrl,
      this.html_url,
      this.type,
      this.public_repos,
      this.followers,
      this.location,
      this.email,
      this.following,
      this.name,
      this.bio});

  @override
  List<Object?> get props {
    //decides wc objects we should consider for comparison
    return [
      name,
      avatarUrl,
      html_url,
      bio,
      location,
      email,
      following,
      public_repos,
      followers
    ];
  }
}
