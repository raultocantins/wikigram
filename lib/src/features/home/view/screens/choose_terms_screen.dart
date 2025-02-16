import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wikigram/src/core/utils/string_constants.dart';
import 'package:wikigram/src/core/utils/terms_enum.dart';
import 'package:wikigram/src/core/utils/text_styles.dart';
import 'package:wikigram/src/features/home/view_model/home_view_model.dart';

class ChooseTermsScreen extends StatefulWidget {
  const ChooseTermsScreen({super.key});

  @override
  State<ChooseTermsScreen> createState() => _ChooseTermsScreenState();
}

class _ChooseTermsScreenState extends State<ChooseTermsScreen> {
  late HomeViewModel _controller;

  @override
  void initState() {
    super.initState();
    _controller = Provider.of<HomeViewModel>(context, listen: false);
    systemNavigationBarColor();
  }

  void systemNavigationBarColor() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final surface = Theme.of(context).colorScheme.surface;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: surface,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              StringConstants.chooseTermsTitle,
              style: title,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              StringConstants.chooseTermsMessage,
              style: description,
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: TermEnum.values.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      TermEnum.values[index].displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Checkbox(
                      value: _controller.searchTerm == TermEnum.values[index],
                      onChanged: (_) {
                        _controller.changeSearchTerm(
                          context,
                          TermEnum.values[index],
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
