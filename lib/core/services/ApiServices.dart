import 'dart:convert';
import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://133c52ff-959b-4eb8-af77-ada3a9c25827.mock.pstmn.io';
  
  Future<HomeResponse> fetchHomeSections() async {
    final response = await http.get(Uri.parse('$baseUrl/home'));
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return HomeResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load home sections. Status code: ${response.statusCode}');
    }
  }
}