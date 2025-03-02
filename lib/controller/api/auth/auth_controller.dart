import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/colors.dart';
import '../../../view/screens/home/home.dart';
import 'auth_service.dart';


class AuthController extends GetxController {
  var isLoading = false.obs;
  String? token;
  final AuthService _authService = AuthService(); // Use service

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final result = await _authService.login(email, password);
   log(result!);
    if (result != null) {
      token = result;
      print("Token: $token");
      Get.offAll(Home());// Navigate to home
    } else {
      Get.snackbar(
        "Error",
        "Invalid credentials",
        snackPosition: SnackPosition.BOTTOM, // Position at bottom
        backgroundColor: redCheck, // Red background
        colorText: Colors.white, // White text
        borderRadius: 8,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2), // Auto dismiss after 2 seconds
        icon: Icon(Icons.error, color: Colors.white), // Add an icon
      );

    }

    isLoading.value = false;
  }
}
