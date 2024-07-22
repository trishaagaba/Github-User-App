import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/user_entity.dart';

//decode the api response and convert it into a list of 'UserEntity' objects
class DataSource {
    Future<List<UserEntity>> fetchUsersByLocation(String? location,String? name, int page, int pageSize) async {
      String url = "https://api.github.com/search/users?q=location:$location&page=$page&per_page=$pageSize";

      https://api.github.com/search/users?since=page=$page&per_page=$pageSize
      if(location != null){
        url = "https://api.github.com/search/users?q=location:$location&page=$page&per_page=$pageSize";
      } else if (name != null){
        url = "https://api.github.com/search/users?q=name&page=$page&per_page=$pageSize";
      }
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item){
        return UserEntity(
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

