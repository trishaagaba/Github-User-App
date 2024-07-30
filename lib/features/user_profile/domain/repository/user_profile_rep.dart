import 'package:git_user_app/features/user_profile/domain/entities/user_profile_entity.dart';

abstract class UserProfileRep {
  Future<UserProfileEntity> getUserProfile(String username);
}
