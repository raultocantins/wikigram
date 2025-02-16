import 'package:flutter/material.dart';
import 'package:wikigram/src/core/utils/languages_enum.dart';
import 'package:wikigram/src/core/utils/terms_enum.dart';
import 'package:wikigram/src/features/home/model/post_entity.dart';
import 'package:wikigram/src/features/home/model/repositories/language_repository.dart';
import 'package:wikigram/src/features/home/model/repositories/posts_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostsRepository postsRepository;
  final LanguageRepository languageRepository;

  HomeViewModel({
    required this.postsRepository,
    required this.languageRepository,
  });

  List<PostEntity> posts = [];

  bool? isLoading;

  LanguageEnum? language;

  TermEnum? searchTerm;

  Future<void> init(BuildContext context) async {
    language = languageRepository.getLanguage();
    await getPosts(context);
  }

  Future<void> getPosts(BuildContext context) async {
    try {
      isLoading = true;

      final result = await postsRepository.getPosts(
        language!,
        searchTerm: searchTerm?.name,
      );
      posts = [...posts, ...result];
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        _precacheImages(context);
      }
    } catch (err) {
      debugPrint(err.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  void _precacheImages(BuildContext context) {
    for (var post in posts) {
      if (post.imageUrl != null && post.imageUrl!.isNotEmpty) {
        precacheImage(NetworkImage(post.imageUrl!), context);
      }
    }
  }

  void changeLanguage(BuildContext context, LanguageEnum newLanguage) async {
    try {
      await languageRepository.changeLanguage(newLanguage);
      language = newLanguage;
      posts = [];
      notifyListeners();
      if (context.mounted) {
        getPosts(context);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void changeSearchTerm(BuildContext context, TermEnum searchTerm) async {
    try {
      this.searchTerm = searchTerm;
      posts = [];
      notifyListeners();
      if (context.mounted) {
        getPosts(context);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
