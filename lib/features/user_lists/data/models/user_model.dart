import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    super.name,
    super.url,
    super.type,
    super.avatar_url,

});

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
