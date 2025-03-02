import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {

  Future<String?> login(String email, String password) async {
    final url = Uri.parse("https://apichat.nanoegypt.com/public/api/login");
 log("email $email and password $password");

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
        log("successful 1");
        final data = jsonDecode(response.body);
        log("successful");
        return data['data']['token']; // Return token
      } else {
        return null; // Login failed
      }
    } catch (e) {
      return null; // Handle API call failure
    }
  }
}
