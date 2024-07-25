import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user_model.dart';

class DataSource {
    Future<List<UserModel>> fetchUsersByLocation(String? location,String? name, int page, int pageSize) async {
      String url = "https://api.github.com/search/users?q=location:$location&page=$page&per_page=$pageSize";

      if(location != null){
        url = "https://api.github.com/search/users?q=location:$location&page=$page&per_page=$pageSize";
      } else if (name != null){
        url = "https://api.github.com/search/users?q=$name";
      }
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item){
        return UserModel(
          name: item['login'],
          avatar_url: item['avatar_url'],
          type: item['type']
        );
      }).toList();
    }
    else{
      throw Exception('Failed to load users: ${response.reasonPhrase}');
    }
  }


}


