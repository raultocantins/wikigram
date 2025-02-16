import 'package:wikigram/src/features/home/model/post_entity.dart';

class PostModel {
  final String title;
  final String description;
  final String? imageUrl;
  PostModel({
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] ?? 'No title',
      description: json['extract'] ?? 'No description',
      imageUrl: json['thumbnail'] != null ? json['thumbnail']['source'] : null,
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
