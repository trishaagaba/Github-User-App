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

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'html_url': instance.html_url,
      'public_repos': instance.public_repos,
      'type': instance.type,
      'avatarUrl': instance.avatarUrl,
      'followers': instance.followers,
      'location': instance.location,
      'email': instance.email,
      'following': instance.following,
      'bio': instance.bio,
    };
