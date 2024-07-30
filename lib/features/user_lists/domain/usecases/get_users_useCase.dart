import 'package:git_user_app/features/user_lists/domain/repository/user_repository.dart';

import '../entities/user_entity.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<List<UserEntity>> execute(
      String? location, String? name, int page, int pageSize) async {
    return await _userRepository.getUsers(location, name, page, pageSize);
  }
}
