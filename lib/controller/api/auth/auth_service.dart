import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {
String baseUrl="https://apichat.nanoegypt.com/public/api/";
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

        return data['data']['token']; // Return token
      } else {
        return null; // Login failed
      }
    } catch (e) {
      return null; // Handle API call failure
    }
  }

  Future<String?> register(String name,String email, String password,String password_confirm) async {
    final url = Uri.parse("${baseUrl}register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name":name,
          "email": email,
          "password": password,
          "password_confirmation": password_confirm
        }),
      );
      log(response.body+response.statusCode.toString());
      if (response.statusCode == 201) {

        final data = jsonDecode(response.body);

        return data['data']['id']; // Return token
      } else {
        return null; // Login failed
      }
    } catch (e) {
      return null; // Handle API call failure
    }
  }
}
