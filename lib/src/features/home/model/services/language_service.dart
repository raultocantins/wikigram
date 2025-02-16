import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  final SharedPreferences prefs;
  LanguageService({required this.prefs});

  Future<void> changeLanguage(String newLanguage) async {
    await prefs.setString('language', newLanguage);
  }

  String getLanguage() {
    return prefs.getString('language') ?? 'pt';
  }
}
