// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      name: json['login'] as String?,
      email: json['email'] as String?,
      html_url: json['html_url'] as String?,
      type: json['type'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      public_repos: (json['public_repos'] as num?)?.toInt(),
      avatarUrl: json['avatar_url'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
    );
