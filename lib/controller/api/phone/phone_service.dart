import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../model/retrieve_contact.dart';
import '../auth/auth_service.dart';


class PhoneService {


  Future<List<ContactModel>> validatePhoneNumber(String phoneNumber,String token) async {
    final url = Uri.parse("${baseUrl}contacts/check");
    log("in api $phoneNumber");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',    'Authorization': 'Bearer $token',},
      body: jsonEncode({'phones': [phoneNumber]}),
    );
   log(response.statusCode.toString());
   log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return (data['contacts'] as List)
            .map((contact) => ContactModel.fromJson(contact))
            .toList();
      }
    }
    return [];
  }
}
