// import 'package:flutter/foundation.dart';
// import 'package:git_user_app/features/user_lists/data/datasources/remote/data_source.dart';
//
// class FilterProvider extends ChangeNotifier {
//   final DataSource _dataSource = DataSource();
//
//   List<dynamic> _filteredUsers = [];
//   bool _isFiltering = false;
//
//   List<dynamic> get filteredUsers => _filteredUsers;
//   bool get isFiltering => _isFiltering;
//
//   Future<void> fetchUserDetails(String username) async {
//     _setFiltering(true);
//     try {
//       final userDetails = await _dataSource.fetchUserDetails(username);
//       _setFilteredUsers(userDetails);
//     } catch (e) {
//       print('Error fetching user details: $e');
//       _setFilteredUsers([]);
//     } finally {
//       _setFiltering(false);
//     }
//   }
//
//   Future<void> applyFilters(List<dynamic> users, String name, String type, int followers, int following) async {
//     _setFiltering(true);
//
//     try {
//       final filteredUsers = users.where((user) {
//         final matchesName = name.isEmpty || user['login'].toLowerCase().contains(name.toLowerCase());
//         final matchesType = type.isEmpty || user['type'].toLowerCase().contains(type.toLowerCase());
//
//         final userFollowers = user['followers'] ?? 0;
//         final userFollowing = user['following'] ?? 0;
//
//         final matchesFollowers = followers == 0 || userFollowers >= followers;
//         final matchesFollowing = following == 0 || userFollowing >= following;
//
//         return matchesName && matchesType && matchesFollowers && matchesFollowing;
//       }).toList();
//
//       _setFilteredUsers(filteredUsers);
//     } catch (e) {
//       print('Error applying filters: $e');
//       _setFilteredUsers([]);
//     } finally {
//       _setFiltering(false);
//     }
//   }
//
//   void _setFilteredUsers(List<dynamic> users) {
//     _filteredUsers = users;
//     notifyListeners();
//   }
//
//   void _setFiltering(bool isFiltering) {
//     _isFiltering = isFiltering;
//     notifyListeners();
//   }
//
//   void clearFilters() {
//     _filteredUsers = [];
//     notifyListeners();
//   }
// }
