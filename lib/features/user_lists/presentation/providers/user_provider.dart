import 'package:flutter/foundation.dart';
import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:git_user_app/features/user_lists/domain/usecases/get_users_useCase.dart';



class UserProvider extends ChangeNotifier{
  final GetUsersUseCase _getUsersUseCase;

  UserProvider(this._getUsersUseCase);

  List<UserEntity> _users = [];
  final List<UserEntity> _originalUsers = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  bool _hasMore = true;

  List<UserEntity> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;
  bool get hasMore => _hasMore;


  static const _pageSize = 20;
  int _currentPage = 0;

  Future<void> fetchUsers(String query, int page, int pageSize)async {
    if (_isLoading) return;

    await Future.delayed(const Duration(milliseconds: 500));
    // _setLoading(true);
   //notifyListeners();
    try {
      final newUsers = await _getUsersUseCase.execute(
          query, _currentPage, _pageSize);
      if (newUsers.isEmpty) {
        _hasMore = false;

      } else {
        // final existingUserIds = _users.map((user) => user.name).toSet();
        // final uniqueNewUsers = newUsers.where((user)
        // => !existingUserIds.contains(user.name)).toList();
        // _hasSearched = true;
        // Avoid adding duplicates
        final existingUserIds = _users.map((user) => user.name).toSet();
        final uniqueNewUsers = newUsers.where((user) => !existingUserIds.contains(user.name)).toList();

        if (uniqueNewUsers.isNotEmpty) {
          _users.addAll(uniqueNewUsers);
          _currentPage++;
        }
        // _users.addAll(newUsers);
        // _currentPage++;
        _hasMore = true;
        print("real: $newUsers");
      }
    }
      catch(e){
      _isLoading = false;
        _hasMore = false;
        print('Error fetching users22: $e');

    }

    _isLoading = false;
    notifyListeners();
  }


  void applyFilters(String name, String type, int followers, int following){
    final filteredUsers = _users.where((user){
      final matchesName = name.isEmpty;
          // || user.name.toLowerCase().contains(name.toLowerCase());
      final matchesType = type.isEmpty;
          // || user.type.toLowerCase().contains(type.toLowerCase());

      final userFollowers = user.followers ?? 0;
      final userFollowing = user.following ?? 0;

      final matchesFollowers = followers == 0 || userFollowers >= followers;
      final matchesFollowing = following == 0 || userFollowing >= following;

      return matchesName && matchesType && matchesFollowers && matchesFollowing;
    }).toList();

    if (kDebugMode) {
      print('Filtered Users: $filteredUsers');
    }
    _setUsers(filteredUsers);
    notifyListeners();
  }


  void _setUsers(List<UserEntity> users){
    _users = users;
    //notifyListeners();
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setHasSearched(bool hasSearched) {
    _hasSearched = hasSearched;
    notifyListeners();
  }

  void clearFilters(){
    _setUsers(_originalUsers);
    _hasSearched = false;
    notifyListeners();
  }

  void clearSearch(){
    _setUsers([]);
    _setHasSearched(false);
    notifyListeners();
  }

  void clearFiltersAndSearch() {
    _setUsers([]);
    _setHasSearched(false);
    _currentPage = 0;
    //when you clear, the search should clear
    fetchUsers('',0,_pageSize);
    _hasMore = true;
    notifyListeners();
  }


  // Future<List<dynamic>> fetchUserDetails(String username) async {
  //   final response = await _dataSource.fetchUserDetails(username);
  //   final List<dynamic> detailedUsers = [];
  //   for (var user in users) {
  //     final userDetails = await fetchUsersByLocation(user['url']);
  //     detailedUsers.add(userDetails);
  //   }
  // }

}