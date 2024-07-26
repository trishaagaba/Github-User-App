import 'package:flutter/foundation.dart';
import 'package:git_user_app/features/user_profile/domain/entities/userprofile_entity.dart';
import 'package:git_user_app/features/user_profile/domain/usecases/userdetails_usecase.dart';

class UserProfileProvider extends ChangeNotifier {
  final UserdetailsUsecase _userDetailsUsecase;

  UserProfileProvider(this._userDetailsUsecase);

 UserProfileEntity? _user;
  UserProfileEntity? get user => _user;

  Future<void> fetchUserProfile(String username) async {
    try {
      final user = await _userDetailsUsecase.execute(username);
      _showUserDetails(user);
    } catch (e) {

      if (kDebugMode) {
        print('Failed to fetch user profile: $e');
      }
      _user = null;
    }
    notifyListeners();
  }

  void _showUserDetails(UserProfileEntity user) {
    _user = user;
    notifyListeners();
  }

}