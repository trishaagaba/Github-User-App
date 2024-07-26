import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';

abstract class UserProfileRep{
  Future<UserProfileEntity> getUserProfile(String username);
}
