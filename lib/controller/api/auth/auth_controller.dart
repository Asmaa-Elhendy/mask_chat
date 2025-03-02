import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/colors.dart';
import '../../../view/screens/home/home.dart';
import '../../../view/screens/login/login.dart';
import 'auth_service.dart';


class AuthController extends GetxController {
  var isLoading = false.obs;
  String? token;
  String? id;
  final AuthService _authService = AuthService(); // Use service

  Future<void> login(String email, String password,localizations) async {
    isLoading.value = true;

    final result = await _authService.login(email, password);
   log(result!);
    if (result != null) {
      token = result;
      print("Token: $token");
      Get.offAll(Home());// Navigate to home
    } else {
      SnackBarWidget(localizations,localizations.invalidCredentials);

    }

    isLoading.value = false;
  }

  Future<void> register(String name,String email, String password,String password_confirm,localizations) async {
    isLoading.value = true;

    final result = await _authService.register(name,email,password,password_confirm);
    log(result!);
    if (result =='error') {
      SnackBarWidget(localizations,localizations.invalidCredentials);
    }else
    if (result =='success') {
      // log('jjj');
      // id = result;
      // print("id: $id");
      Get.offAll(Login());// Navigate to home
    } else {
      SnackBarWidget(localizations,localizations.invalidCredentials);

    }

    isLoading.value = false;
  }
}

SnackbarController SnackBarWidget(localizations,String description){
 return Get.snackbar(
   localizations.errorMessage,
    description,
    snackPosition: SnackPosition.BOTTOM, // Position at bottom
    backgroundColor: redCheck, // Red background
    colorText: Colors.white, // White text
    borderRadius: 8,
    margin: EdgeInsets.all(10),
    duration: Duration(seconds: 2), // Auto dismiss after 2 seconds
    icon: Icon(Icons.error, color: Colors.white), // Add an icon
  );
}