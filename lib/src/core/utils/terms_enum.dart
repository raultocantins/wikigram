enum TermEnum {
  tecnologia,
  ciencia,
  historia,
  saude,
  educacao,
  esportes,
  entretenimento,
  economia,
  politica,
  cultura,
}

extension TermsEnumPtExtension on TermEnum {
  String get displayName {
    switch (this) {
      case TermEnum.tecnologia:
        return "Tecnologia";
      case TermEnum.ciencia:
        return "Ciência";
      case TermEnum.historia:
        return "História";
      case TermEnum.saude:
        return "Saúde";
      case TermEnum.educacao:
        return "Educação";
      case TermEnum.esportes:
        return "Esportes";
      case TermEnum.entretenimento:
        return "Entretenimento";
      case TermEnum.economia:
        return "Economia";
      case TermEnum.politica:
        return "Política";
      case TermEnum.cultura:
        return "Cultura";
    }
  }

  static TermEnum? fromString(String value) {
    return TermEnum.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
    );
  }
}
