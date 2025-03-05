import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/messages.dart';


class MessageService {

  Future< List<Messages>> getChatMesssages(String token,String chatId) async {
    log("in get messages api");
    try {
      final String url = "${baseUrl}messages/$chatId";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    log(chatId+response.body+token);
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