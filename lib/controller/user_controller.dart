import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  var user = Rxn<UserModel>(); // Reactive variable
  var isLoading = true.obs; // Observable boolean

  final AuthService _userApiService = AuthService();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    isLoading.value = true;

    UserModel? fetchedUser = await _userApiService.fetchUser();
    if (fetchedUser != null) {
      user.value = fetchedUser;
    }

    isLoading.value = false;
  }
}
