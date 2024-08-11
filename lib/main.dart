import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/language_controller.dart';
import 'package:sample/utils/app_translation.dart';
import 'package:sample/views/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());
    return Obx(
      () => GetMaterialApp(
        translations: AppTranslations(),
        locale: languageController.currentLocale.value, // Default locale
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const <Locale>[
          Locale('en', 'US'),
          Locale('ar', 'SA')
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        title: 'Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.brown),
          ),
        ),
        home: const CategoryScreen(),
      ),
    );
  }
}
