//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? url;
  final String? avatar_url;
  final String? type;

  const UserEntity({
    this.avatar_url,
    this.url,
    this.type,
    this.name,
  });

  @override
  List<Object?> get props {
    return [
      name,
      avatar_url,
      type,
      url,
    ];
  }
}
