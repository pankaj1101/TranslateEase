import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/category_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A GetxController that manages the language settings
class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  @override
  // Initialize the controller, load the saved language
  void onInit() {
    super.onInit();
    // Load the saved language from SharedPreferences
    _loadSavedLanguage();
  }

  // Change the language and update the UI
  void changeLanguage(String languageCode, String countryCode) async {
    var locale = Locale(languageCode, countryCode);
    currentLocale.value = locale;
    // Update the Getx locale
    Get.updateLocale(locale);

    // Api Call After Language Update.
    // Update the API call with the new language
    updatetheApiCall();

    // Save the selected language
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    await prefs.setString('countryCode', countryCode);
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get the saved language code and country code
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    // If no language is saved, default to English (US)
    if (languageCode == null || countryCode == null) {
      languageCode = 'en';
      countryCode = 'US';

      // Save the selected language to SharedPreferences
      await prefs.setString('languageCode', languageCode);
      await prefs.setString('countryCode', countryCode);
    }
    // If no language is saved, default to English (US)
    var locale = Locale(languageCode, countryCode);
    currentLocale.value = locale;
    // Update the Getx locale
    Get.updateLocale(locale);
  }

  // Make API call to update language
  void updatetheApiCall() {
    // Update the CategoryController with the new language
    Get.find<CategoryController>()
        .getCategory(currentLocale.value.languageCode);
    Get.find<CategoryController>().getProduct(currentLocale.value.languageCode);
  }
}
