import 'package:git_user_app/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.name,
    super.email,
    super.html_url,
    super.type,
    super.bio,
    super.location,
    super.public_repos,
    super.avatarUrl,
    super.followers,
    super.following,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> map) =>
      _$UserProfileModelFromJson(map);

  UserProfileEntity toProfileEntity() {
    return UserProfileEntity(
      name: name,
      html_url: html_url,
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
