import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikigram/src/features/home/model/repositories/language_repository.dart';
import 'package:wikigram/src/features/home/model/repositories/posts_repository.dart';
import 'package:wikigram/src/features/home/model/services/language_service.dart';
import 'package:wikigram/src/features/home/model/services/posts_service.dart';
import 'package:wikigram/src/features/home/view/screens/home_screen.dart';
import 'package:wikigram/src/features/home/view_model/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        languageRepository: LanguageRepository(
          languageService: LanguageService(prefs: prefs),
        ),
        postsRepository: PostsRepository(
          postsService: PostsService(dio: dio),
        ),
      ),
      child: const Root(),
    ),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WikiGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
