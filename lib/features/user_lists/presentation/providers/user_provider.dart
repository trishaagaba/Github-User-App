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
  String? _location;
  String? _name;

  List<UserEntity> get users => _users;


  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;
  bool get hasMore => _hasMore;


  static const _pageSize = 20;
  int _currentPage = 0;

  // String get location => _location;

  void setLocation(String location){
    _location = location;
    _name = null;
    _resetPagination();
    fetchUsers(_location, _name, _currentPage, _pageSize);
  }

  void setName(String name){
    _name = name;
    _location = null;
    _resetPagination();
    fetchUsers(_location, _name, _currentPage, _pageSize);
  }




  Future<void> fetchUsers(String? location, String? name, int page, int pageSize)async {
    if (_isLoading) return;

    await Future.delayed(const Duration(milliseconds: 500));
    //_setLoading(true);
   //notifyListeners();
    try {
      final newUsers = await _getUsersUseCase.execute(
          _location, _name, _currentPage, _pageSize);
      if (newUsers.isEmpty) {
        _hasMore = false;

      } else {

        final existingUserIds = _users.map((user) => user.name).toSet();
        final uniqueNewUsers = newUsers.where((user) => !existingUserIds.contains(user.name)).toList();

        if (uniqueNewUsers.isNotEmpty) {
          _users.addAll(uniqueNewUsers);

        }
        _currentPage++;
        _hasMore = true;
        _setHasSearched(true);
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

  void _setUsers(List<UserEntity> users){
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
    _resetPagination();
    _clearTextFields();
    fetchUsers(_location, null, _currentPage, _pageSize);
    _hasMore = true;
    notifyListeners();
  }
  void _resetPagination(){
    _setUsers([]);
    _currentPage = 0;
    _hasMore = true;
    notifyListeners();
  }

  void _clearTextFields() {
    _location = null;
    _name = null;
    notifyListeners();
  }

}