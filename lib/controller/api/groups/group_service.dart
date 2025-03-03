import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/gtroup.dart';
import '../auth/auth_service.dart';

class GroupService {
  Future<List<Group>> fetchGroups(String token) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}groups"),
        headers: {
          "Authorization": "Bearer ${token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<Group> groups = (data['data'] as List).map((group) {
            return Group(
              id: group['id'],
              fav: false,
              image: "assets/images/categories/Closed friend.png",
              groupContacts: [], // No contacts provided in API response
              subject: group['name'],
            );
          }).toList();
          return groups;
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch groups, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching groups: $e");
    }

    return []; // Return an empty list in case of failure
  }
}
