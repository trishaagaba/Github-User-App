import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';

abstract class UserProfileRep{
  Future<List<UserProfileEntity>> getUserProfile(String username);
}
