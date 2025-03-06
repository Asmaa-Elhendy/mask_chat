import 'dart:developer';
import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  UserModel? user; // Non-reactive variable
  var isLoading = true.obs; // Observable boolean

  final AuthService _userApiService = AuthService();

  @override
  void onInit() {
    super.onInit();
    getUser(user_token.value);
  }

  Future<void> getUser(String token) async {
    isLoading.value = true;
    log("Fetching user data...");

    UserModel? fetchedUser = await _userApiService.fetchUser(token);
    if (fetchedUser != null) {
      user = fetchedUser;
      update(); // Notify UI of the change
    }

    isLoading.value = false;
  }
}
