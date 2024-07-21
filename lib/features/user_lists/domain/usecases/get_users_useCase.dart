import 'package:git_user_app/features/user_lists/domain/repository/user_repository.dart';

import '../entities/user_entity.dart';

class GetUsersUseCase{
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<List<UserEntity>> execute (String query, int page, int pageSize) async {
    return await _userRepository.getUsers(query, page, pageSize);
  }
}