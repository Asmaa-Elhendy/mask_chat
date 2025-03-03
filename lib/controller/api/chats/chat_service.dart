import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/contacts.dart';

class ChatService {
  //get chats not handeled yet, then handle with chat controller like group controller and adjust ui like them
  static Future<List<Contacts>> getContacts(String token) async {
    try {
      final String url = "${baseUrl}chats"; // Adjust endpoint as needed
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          List<dynamic> contactsJson = data['data'];
          return contactsJson.map((json) {
            try {
              return Contacts.fromJson(json);
            } catch (e) {
              print("Error parsing contact: $e");
              return Contacts(
                id: 0,
                name: "Unknown",
                image: "",
                numOfMessage: "0",
                closed: false,
                tag: "",
                isSelected: false,
              ); // Fallback contact object
            }
          }).toList();
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch contacts, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching contacts: $e");
    }

    return []; // Return an empty list on failure
  }
}
