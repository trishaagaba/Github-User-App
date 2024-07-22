import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';

import '../repository/user_profile_rep.dart';


class UserdetailsUsecase{
  final UserProfileRep _userProfileRep;

  UserdetailsUsecase(this._userProfileRep);

Future<UserProfileEntity> execute (String username) async {
  return await _userProfileRep.getUserProfile(username);
}}