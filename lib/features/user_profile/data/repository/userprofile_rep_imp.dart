
import 'package:git_user_app/features/user_profile/data/datasources/data_source.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:git_user_app/features/user_profile/domain/repository/user_profile_rep.dart';

class UserprofileRepImp implements UserProfileRep {
  final DataSource _dataSource;

  UserprofileRepImp(this._dataSource);

  @override
  Future<List<UserProfileEntity>> getUserProfile(String username) async {
    return await _dataSource.fetchUserDetails(username);
  }
}
