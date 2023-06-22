import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tif_assg/modles/user_model.dart';


class UserRepository {
  String endpoint = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event';

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['content']['data'] as List<dynamic>;
    final userModels = data
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return userModels;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
                                                                                                   