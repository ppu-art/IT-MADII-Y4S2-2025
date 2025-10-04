import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mad/firebase_options.dart';
import 'package:mad/screens/splash_screen.dart';
import 'package:mad/translate/app_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PPUA',
      home: SplashScreen(),
      translations: AppTranslate(),
      locale: Get.deviceLocale,
      supportedLocales: [Locale("en", ""), Locale("km", "")],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light, //
    );
  }
}
