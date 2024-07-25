import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    final String ? name,
    final String ? url,
    final String ? type,
    final String ? avatar_url,

}): super(
    name: name,
    url: url,
    avatar_url: avatar_url,
    type: type,
  );

  factory UserModel.fromJson(Map <String, dynamic> map){
    return UserModel(
      name: map['login'] ?? "",
      url: map['url'] ?? "",
      type: map['type'] ?? "",
      avatar_url: map['avatar_url'] ?? "",

    );
  }
  UserEntity toEntity() {
    return UserEntity(
      name: name,
      avatar_url: avatar_url,
      type: type,
    );
  }
}
