import 'package:flutter/material.dart';
import 'package:wikigram/src/core/utils/languages_enum.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageEnum? defaultLanguage;
  final void Function(LanguageEnum value) onChanged;
  const LanguageWidget({
    required this.onChanged,
    required this.defaultLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: LanguageEnum.values.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              LanguageEnum.values[index].fullName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Checkbox(
              value: defaultLanguage == LanguageEnum.values[index],
              onChanged: (_) {
                Navigator.of(context).pop();
                onChanged(LanguageEnum.values[index]);
              },
            ),
            leading: Text(
              LanguageEnum.values[index].flag,
              style: const TextStyle(fontSize: 34),
            ),
          );
        },
      ),
    );
  }
}
