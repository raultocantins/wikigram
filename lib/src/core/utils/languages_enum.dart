enum LanguageEnum { en, pt, es, de, fr, it, ja, zh, ru }

extension LanguageEnumExtension on LanguageEnum {
  String get fullName {
    switch (this) {
      case LanguageEnum.en:
        return 'English';
      case LanguageEnum.pt:
        return 'Português';
      case LanguageEnum.es:
        return 'Español';
      case LanguageEnum.de:
        return 'Deutsch';
      case LanguageEnum.fr:
        return 'Français';
      case LanguageEnum.it:
        return 'Italiano';
      case LanguageEnum.ja:
        return '日本語 (Japanese)';
      case LanguageEnum.zh:
        return '中文 (Chinese)';
      case LanguageEnum.ru:
        return 'Русский (Russian)';
    }
  }

  String get flag {
    switch (this) {
      case LanguageEnum.en:
        return '🇬🇧';
      case LanguageEnum.pt:
        return '🇧🇷';
      case LanguageEnum.es:
        return '🇪🇸';
      case LanguageEnum.de:
        return '🇩🇪';
      case LanguageEnum.fr:
        return '🇫🇷';
      case LanguageEnum.it:
        return '🇮🇹';
      case LanguageEnum.ja:
        return '🇯🇵';
      case LanguageEnum.zh:
        return '🇨🇳';
      case LanguageEnum.ru:
        return '🇷🇺';
      default:
        return '';
    }
  }

  static LanguageEnum fromString(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return LanguageEnum.en;
      case 'pt':
        return LanguageEnum.pt;
      case 'es':
        return LanguageEnum.es;
      case 'de':
        return LanguageEnum.de;
      case 'fr':
        return LanguageEnum.fr;
      case 'it':
        return LanguageEnum.it;
      case 'ja':
        return LanguageEnum.ja;
      case 'zh':
        return LanguageEnum.zh;
      case 'ru':
        return LanguageEnum.ru;
      default:
        throw ArgumentError('Invalid language code: $languageCode');
    }
  }
}
