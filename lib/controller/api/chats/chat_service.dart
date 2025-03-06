import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/contacts.dart';
import '../../../model/retrieve_contact.dart';

class ChatService {
  //get chats not handeled yet, then handle with chat controller like group controller and adjust ui like them in empty and loading
   Future<List<ChatContact>> getChats(String token) async {
     log("in get chats api");
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

              return ChatContact.fromJson(json);

          }).toList();
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch chats, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching contacts: $e");
    }

    return []; // Return an empty list on failure
  }

  //delete chat without backend  , handle the delete chat controller
  static Future<bool> deleteChat(int id, String token) async {
    final String url = "${baseUrl}chats/$id"; // API endpoint
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Pass the user's token
      },
    );

    if (response.statusCode == 200) {
      return true; // Chat deleted successfully
    } else {
      return false; // Failed to delete chat
    }
  }

  static Future<String> createChat(ContactModel contact,String token,int groupValue) async {
    final url = Uri.parse("${baseUrl}chats");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',    'Authorization': 'Bearer $token',},
      body: jsonEncode({
        "contact_id": contact.id,
        "is_masked":groupValue==0?'0':'1'
      }),
    );
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 201) {
      return '201';
    }else if(response.statusCode==200){
      return '200';
    }
    return 'other';
  }}
