import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../model/user_model.dart';

String baseUrl="https://apichat.nanoegypt.com/public/api/";
ValueNotifier<String> user_token= ValueNotifier<String>("");
class AuthService {

  Future<String?> login(String email, String password) async {
    final url = Uri.parse("${baseUrl}login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,

        }),
      );
      log(response.body+response.statusCode.toString());
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        user_token.value=data['token'];
        return data['token']; // Return token
      } else {
        return null; // Login failed
      }
    } catch (e) {
      return null; // Handle API call failure
    }
  }

  Future<String?> register(String name,String email, String password,String password_confirm,String phone) async {
    final url = Uri.parse("${baseUrl}register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name":name,
          "email": email,
          "password": password,
          "password_confirmation": password_confirm,
          "phone": phone
        }),
      );
      log("nowwwwwwwwww");
      log(response.body+response.statusCode.toString()+'here');
      if (response.statusCode == 201) {

        final data = jsonDecode(response.body);

        return 'success'; // Return token
      } else
        if (response.statusCode==401||response.statusCode==200||response.statusCode==302) {
        log("error");
        return 'error';
      }
        return null; // Login failed

    } catch (e) {
      return null; // Handle API call failure
    }
  }
  // Fetch user data from API
  Future<UserModel?> fetchUser() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}user'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data);
      } else {
        print("Failed to fetch user: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }
}
