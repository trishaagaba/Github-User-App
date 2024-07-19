import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import '../../../../core/resources/data_state.dart';
//domain layer only contains the interfaces

abstract class UserRepository{
  Future<DataState<List<UserEntity>>> getUsers(String query, int page, int pageSize);

  // Future<DataState<List<UserEntity>>> getUsers(String query, int page, int pageSize);
}