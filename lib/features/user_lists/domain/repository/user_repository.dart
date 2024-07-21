import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
//domain layer only contains the interfaces

abstract class UserRepository{
  Future<List<UserEntity>> getUsers(String query, int page, int pageSize);

}