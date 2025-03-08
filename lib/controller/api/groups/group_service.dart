import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../model/GroupMember.dart';
import '../../../model/gtroup.dart';
import '../../../model/retrieve_contact.dart';
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

  //delete group no handeled from backend yey:
  static Future<bool> deleteGroup(int id,String token) async {
    final String url = "${baseUrl}groups/$id"; // Adjust endpoint as needed
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Replace with actual token
      },
    );

    if (response.statusCode == 200) {
      return true; // Deletion successful
    } else {
      return false; // Handle failure
    }
  }

  Future<List<GroupMember>> fetchGroupMembers(String token, String groupId) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}groups/$groupId/members"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<GroupMember> members = (data['data'] as List).map((member) {
            return GroupMember.fromJson(member);
          }).toList();
          return members;
        } else {
          print("Error: API response was unsuccessful");
        }
      } else {
        print("Error: Failed to fetch group members, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching group members: $e");
    }

    return []; // Return an empty list in case of failure
  }
  static Future<String> createGroup(String token,String groupName,List<ContactModel> contacts) async {
    List<String> selectedContactsIds=[];
        contacts.forEach((ContactModel contact){
        selectedContactsIds.add(contact.id.toString());
    });
    final url = Uri.parse("${baseUrl}groups");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',    'Authorization': 'Bearer $token',},
      body: jsonEncode({
        "name": groupName,
        "members": selectedContactsIds
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
  static Future<String> createGroupMember(String token,String groupId,String userId) async {

    final url = Uri.parse("${baseUrl}groups/$groupId/members");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',    'Authorization': 'Bearer $token',},
      body: jsonEncode({
        "user_id": userId
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
}
