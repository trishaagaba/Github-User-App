import 'package:flutter/foundation.dart';
import 'package:git_user_app/features/user_lists/data/datasources/remote/data_source.dart';

class UserProvider extends ChangeNotifier{
  final DataSource _dataSource = DataSource();

  List<dynamic> _users = [];
  List<dynamic> _originalUsers = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  List<dynamic> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;

  static const _pageSize = 20;


  Future<void> fetchUsersByLocation(String query, int pageKey) async {
    _setLoading(true);
    try{
      final users = await _dataSource.fetchUsersByLocation(query, pageKey, _pageSize);

    _originalUsers.addAll(users);
    _setUsers(users);
    _setHasSearched(true);
    notifyListeners();
    }
     catch(e){
      _setUsers([]);
      _setHasSearched(true);
      // _originalUsers = List.from(users);
      print('Error fetching users: $e');
    }finally {
      _setLoading(false);
    }
  }

  void applyFilters(String name, String type, int followers, int following){
    final filteredUsers = _users.where((user){
      final matchesName = name.isEmpty || user['login'].toLowerCase().contains(name.toLowerCase());
      final matchesType = type.isEmpty || user['type'].toLowerCase().contains(type.toLowerCase());

      final userFollowers = user['followers'] ?? 0;
      final userFollowing = user['following'] ?? 0;

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


  void _setUsers(List<dynamic> users){
    _users = users;
    notifyListeners();
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
    //when you clearf the search should clear
    fetchUsersByLocation('',0);
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