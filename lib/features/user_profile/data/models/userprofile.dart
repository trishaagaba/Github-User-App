// import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';


class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    final String ? name,
    final String ? email,
    final String ? url,
    final String ? type,
    final String ? bio,
    final String ? location,
    final int ? public_repos,
    final String ? avatarUrl,
    final int ? followers,
    final int ? following,
  });

  factory UserProfileModel.fromJson(Map <String, dynamic> map){
    return UserProfileModel(
      name: map['login'] ?? "",
      url: map['url'] ?? "",
      bio: map['bio'] ?? '',
      public_repos: map['public_repos'] ?? 0,
      location: map['location'] ?? '',
      type: map['type'] ?? '',
      email: map['email'] ?? "",
      avatarUrl: map['avatar_url'] ?? "",
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,

    );
  }

  UserProfileEntity toProfileEntity() {
    return UserProfileEntity(
      name: name,
      avatarUrl: avatarUrl,
      bio: bio,
      public_repos: public_repos,
      location: location,
      type: type,
      email: email,
      followers: followers,
      following: following,


    );
  }

}