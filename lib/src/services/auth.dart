import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String,dynamic>> login(String username, String password) async {
    final response = await client.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": username, "password": password}),
    );
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // store user info (token) into shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // setState()
      final decodedBody = json.decode(response.body);
      await prefs.setString("user_token", decodedBody["accessToken"]);
      return decodedBody; 
    } else {
      throw Exception("Failed to login");
    }
  }
}

// final SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.getString("user_token")

// add profile icon to the posts screen
// profile icon push() the profile screen
// display 
//
// "username": "emilys",
// "email": "emily.johnson@x.dummyjson.com",
// "firstName": "Emily",
// "lastName": "Johnson",
//
// inside the profile screen