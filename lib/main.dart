import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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

Future<void> dbDemo() async {
  // Create Instance
  final db = FirebaseDatabase.instance;
  // Ref
  String refId = "users";

  // Post Data
  final Map<String, Object> dataReq = {
    "username": "kang.kay",
    "email": "kang.kay@gmail.com",
    "phoneNumber": "070446699",
    "gender": "M",
  };
  db.ref(refId).push().set(dataReq);

  // Get Data
  await db.ref(refId).onValue.map((event) {
    print("data : ${event.snapshot.value}");
  });
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
