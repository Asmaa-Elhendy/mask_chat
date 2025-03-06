import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:Whatsback/generated/l10n.dart';
import 'package:Whatsback/l10n/l10n.dart';
import 'package:Whatsback/view/screens/splash_screen.dart';
import 'package:Whatsback/view/widgets/alert_warning.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'controller/api/chats/chats_controller.dart';
import 'controller/binding.dart';
import 'controller/language.dart';
import 'controller/user_controller.dart';
Future<bool> requestPermission() async {
  PermissionStatus status = await Permission.contacts.request();

  print("status$status");

  return status.isGranted;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => LanguageController(),fenix: true);



  requestPermission();
  runApp(

      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
        final languageController = Get.find<LanguageController>();

        return GetMaterialApp(
          translations: AppTranslations(), // Load translations
          locale: Get
              .find<LanguageController>()
              .locale,
          // Initial locale
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Whatsback',

          initialBinding: MyBinding(),

          home: const SplashScreen(),


        );
      } );
  }

}
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'contacts': 'Contacts',
      'closed_friend': 'Closed Friend',
      'friends': 'Friends',
      'workmates': 'Workmates',
      'family': 'Family',
      'unnamed': 'Unnamed',
    },
    'ar': {
      'contacts': 'جهات الاتصال',
      'closed_friend': 'الاصدقاء المقربين',
      'friends': 'الاصدقاء',
      'workmates': 'زملاء العمل',
      'family': 'العائلة',
      'unKnown': 'غير معروف',
    },
    'ru':{
      'contacts': 'Контакты',
      'closed_friend': "Близкий друг",
      'friends': "Друзья",
      'workmates': "Коллеги",
      'family': "Семья",
      'unKnown': "Неизвестно",

    },
    'tr':{
      'contacts': 'Kişiler',
      'closed_friend': "Yakın Arkadaş",
      'friends': "Arkadaşlar",
      'workmates': "İş Arkadaşları",
      'family': "Aile",
      'unKnown': "Bilinmeyen",
    }
  };
}
