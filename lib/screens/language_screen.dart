import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool _isEnglish = true;

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  Future<void> _getLanguage() async {
    Locale? currentLocale = Get.locale;
    print(currentLocale!.languageCode);
    if (currentLocale.languageCode == "km") {
      setState(() {
        _isEnglish = false;
      });
    }
  }

  Future<void> _changeLanguage(Locale locale) async {
    print("Current Language : ${locale.languageCode}");
    await Get.updateLocale(locale);
    print("Current deviceLocale : ${Get.deviceLocale!.languageCode}");
    setState(() {
      _isEnglish = locale.languageCode == "en" ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "language".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            trailing: Checkbox(
              value: !_isEnglish,
              onChanged: (value) {
                _changeLanguage(Locale("km", ""));
              },
            ),
            title: Text("khmer".tr),
            subtitle: Text("khmerLanguage".tr),
            leading: Icon(Icons.language),
          ),
          Divider(),
          ListTile(
            trailing: Checkbox(
              value: _isEnglish,
              onChanged: (value) {
                _changeLanguage(Locale("en", ""));
              },
            ),
            title: Text("english".tr),
            subtitle: Text("englishLanguage".tr),
            leading: Icon(Icons.language),
          ),
          Divider(),
        ],
      ),
    );
  }
}
