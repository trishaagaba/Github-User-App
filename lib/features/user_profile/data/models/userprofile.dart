import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.name,
    super.email,
    super.url,
    super.type,
    super.bio,
    super.location,
    super.public_repos,
    super.avatarUrl,
    super.followers,
    super.following,
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