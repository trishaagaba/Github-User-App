import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_lists/data/datasources/remote/data_source.dart';
import 'package:git_user_app/features/user_lists/domain/entities/user_entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// state management related to user data(loading, searched status)
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
  final PagingController<int,dynamic> pagingController = PagingController(firstPageKey: 0);


  UserProvider() {
    pagingController.addPageRequestListener((pageKey) {
      fetchUsersByLocation('',pageKey);
    });
  }


  Future<void> fetchUsersByLocation(String query, int pageKey) async {
    _setLoading(true);
    try{
      final users = await _dataSource.fetchUsersByLocation(query, pageKey, _pageSize);

      final isLastPage = users.length < _pageSize;
          if(isLastPage){
            pagingController.appendLastPage(users);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(users, nextPageKey);
    }
       _originalUsers.addAll(users);
      _setUsers(users);
      _setHasSearched(true);
    } catch(e){
      pagingController.error = e;
      _setUsers([]);
      _setHasSearched(true);
      _originalUsers = List.from(users);
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