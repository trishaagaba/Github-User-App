import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';


class UserProfileModel extends UserEntity{
  const UserProfileModel({
    final String ? name,
    final int ? id,
    final String ? email,
    final String ? url,
    final String ? avatarUrl,
    final int ? followers,
    final int ? following,
});

  factory UserProfileModel.fromJson(Map <String, dynamic> map){
    return UserProfileModel(
      name: map['login'] ?? "",
      id: map['id'] ?? "",
      url: map['url'] ?? "",
      email: map['email'] ?? "",
      avatarUrl: map['avatar_url'] ?? "",
      followers: map['followers'] ?? "",
      following: map['following'] ?? "",

    );
  }
}

