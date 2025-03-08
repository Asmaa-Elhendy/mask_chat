import 'package:Whatsback/controller/api/phone/phone_service.dart';
import 'package:get/get.dart';
import '../../../model/retrieve_contact.dart';


class PhoneController extends GetxController {
  final PhoneService _phoneService = PhoneService();

  var contactsList = <ContactModel>[].obs;
  var isLoading = false.obs;

  Future<void> checkPhoneNumber(String phoneNumber,String token) async {
    isLoading.value = true;
    final contacts = await _phoneService.validatePhoneNumber(phoneNumber, token);
    contactsList.assignAll(contacts);
    isLoading.value = false;
  }
  clearPhoneslist(){
    contactsList.clear();
    update();
  }
}
