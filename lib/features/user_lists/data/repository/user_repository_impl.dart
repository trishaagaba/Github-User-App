import 'package:git_user_app/features/user_lists/data/datasources/remote/data_source.dart';
import 'package:git_user_app/features/user_lists/data/models/user_model.dart';
import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:git_user_app/features/user_lists/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<UserEntity>> getUsers(
      String? location, String? name, int page, int pageSize) async {
    List<UserModel> userModels =
        await _dataSource.fetchUsersByLocation(location, name, page, pageSize);

    return userModels.map((userModel) => userModel.toEntity()).toList();
  }
}
