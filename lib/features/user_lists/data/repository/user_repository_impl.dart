import 'dart:convert';
import 'package:git_user_app/core/resources/data_state.dart';
import 'package:git_user_app/features/user_lists/data/datasources/remote/data_source.dart';
import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:git_user_app/features/user_lists/domain/repository/user_repository.dart';
import '../models/user.dart';

class UserRepositoryImpl implements UserRepository {
  final DataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<DataState<List<UserEntity>>> getUsers(String query, int page, int pageSize) async {
    try {
      final List<dynamic> users = await _dataSource.fetchUsersByLocation(query, page, pageSize);
      // Convert UserModel to UserEntity if necessary
      final List<UserEntity> userEntities = users.map((user) => UserEntity(
        name: user.login,
        avatar_url: user.avatar_url,
        type: user.type,
        followers: user.followers,
        following: user.following,
      )).toList();

      return DataSuccess(userEntities);

    } catch (e) {
      print(e);
      // Handle the error (e.g., log or show an error message)
      return DataFailed(Exception('Failed to load users'));
    }
  }
}
