import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';


class UserProfileModel extends UserEntity{
  const UserProfileModel({
    final String ? name,
    final String ? email,
    final String ? url,
    final String ? type,
    final String ? bio,
    final String ? public_repos,
    final String ? avatarUrl,
    final int ? followers,
    final int ? following,
});

  factory UserProfileModel.fromJson(Map <String, dynamic> map){
    return UserProfileModel(
      name: map['login'] ?? "",
      url: map['url'] ?? "",
      bio : map['bio'] ?? '',
      public_repos: map['public_repos'] ?? 0,
      type : map['type'] ?? '',
      email: map['email'] ?? "",
      avatarUrl: map['avatar_url'] ?? "",
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,

    );
  }
}

