import 'package:wikigram/src/core/utils/languages_enum.dart';
import 'package:wikigram/src/features/home/model/services/language_service.dart';

class LanguageRepository {
  final LanguageService languageService;
  LanguageRepository({required this.languageService});

  Future<void> changeLanguage(LanguageEnum newLanguage) async {
    await languageService.changeLanguage((newLanguage.name));
  }

  LanguageEnum getLanguage() {
    return LanguageEnumExtension.fromString(languageService.getLanguage());
  }
}
