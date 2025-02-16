import 'package:wikigram/src/core/utils/languages_enum.dart';
import 'package:wikigram/src/features/home/model/post_entity.dart';
import 'package:wikigram/src/features/home/model/services/posts_service.dart';

class PostsRepository {
  final PostsService postsService;
  PostsRepository({required this.postsService});

  Future<List<PostEntity>> getPosts(LanguageEnum language,
      {String? searchTerm}) async {
    try {
      final result = await postsService.getPosts(
        language.name,
        searchTerm: searchTerm,
      );
      return result.map((e) => e.toEntity()).toList();
    } catch (err) {
      throw Exception();
    }
  }
}
