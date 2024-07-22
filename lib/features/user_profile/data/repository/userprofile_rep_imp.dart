
import 'package:git_user_app/features/user_profile/data/datasources/details_source.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:git_user_app/features/user_profile/domain/repository/user_profile_rep.dart';

class UserprofileRepImp implements UserProfileRep {
  final DetailsSource _detailsSource;

  UserprofileRepImp(this._detailsSource);

  @override
  Future<UserProfileEntity> getUserProfile(String username) async {
    return await _detailsSource.fetchUserDetails(username);
  }
}
