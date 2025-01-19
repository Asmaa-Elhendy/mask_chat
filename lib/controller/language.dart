import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  // Default language is English
  Rx<Locale> _locale = Locale('en').obs;

  Locale get locale => _locale.value;

  // Load the saved language when the app starts
  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  // Save the selected language
  void changeLanguage(String languageCode) async {
    if (_locale.value.languageCode == languageCode) return; // Don't update if same language
    _locale.value = Locale(languageCode);  // Update locale
    Get.updateLocale(_locale.value);  // Update the app's locale globally

    // Save to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode);
  }

  // Load the language from SharedPreferences
  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode') ?? 'en';  // Default to 'en' if not found
    _locale.value = Locale(languageCode);
    Get.updateLocale(_locale.value);  // Set the app's locale
  }
}
