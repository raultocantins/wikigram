import 'dart:math';

import 'package:dio/dio.dart';
import 'package:wikigram/src/features/home/model/post_model.dart';

class PostsService {
  final Dio dio;

  PostsService({required this.dio});

  Future<List<PostModel>> getPosts(
    String language, {
    String? searchTerm,
  }) async {
    String endpoint;
    int randomOffset = Random().nextInt(100);

    if (searchTerm == null || searchTerm.isEmpty) {
      endpoint =
          'https://$language.wikipedia.org/w/api.php?action=query&format=json&generator=random&grnnamespace=0&grnlimit=10&prop=extracts|pageimages|info&inprop=url&exintro=1&exsentences=5&explaintext=1&piprop=thumbnail&pithumbsize=400&origin=*';
    } else {
      endpoint =
          'https://$language.wikipedia.org/w/api.php?action=query&format=json&generator=search&gsrsearch=$searchTerm&gsrlimit=10&gsroffset=$randomOffset&prop=extracts|pageimages|info&inprop=url&exintro=1&exsentences=5&explaintext=1&piprop=thumbnail&pithumbsize=400&origin=*';
    }
    try {
      final result = await dio.get(
        endpoint,
      );

      final Map<String, dynamic> json = result.data['query']['pages'];
      return List<Map<String, dynamic>>.from(
        json.values.toList(),
      ).map((e) => PostModel.fromJson(e)).toList();
    } catch (err) {
      rethrow;
    }
  }
}
