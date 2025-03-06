import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/messages.dart';
import '../../../model/retrieve_contact.dart';


class MessageService {

  Future< List<Messages>> getChatMesssages(String token,String chatId) async {

    try {
      final String url = "${baseUrl}messages/$chatId";
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
          List<dynamic> messagesJson = data['data'];

          return messagesJson.map((json) {
            return Messages.fromJson(json);
          }).toList();
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch chat messages, Status Code: ${response
            .statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching chat messages: $e");
    }

    return []; // Return an empty list on failure
  }

   Future<String> sendChatMessage(ChatContact contact,String token,String message) async {
    final url = Uri.parse("${baseUrl}messages");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',    'Authorization': 'Bearer $token',},
      body: jsonEncode({
        "chat_id": contact.id,
        "message": message
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
  }

  Future< List<Messages>> getGroupMesssages(String token,String groupId) async {

    try {
      final String url = "${baseUrl}groups/$groupId/messages";
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
          List<dynamic> messagesJson = data['data'];

          return messagesJson.map((json) {
            return Messages.fromJson(json);
          }).toList();
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch chat messages, Status Code: ${response
            .statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching chat messages: $e");
    }

    return []; // Return an empty list on failure
  }
}