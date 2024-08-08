import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "user_model.g.dart";

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    super.name,
    super.url,
    super.type,
    super.avatar_url,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Map<String, dynamic> toJson => _$UserToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      avatar_url: avatar_url,
      type: type,
    );
  }
}
