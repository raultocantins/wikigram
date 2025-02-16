class PostEntity {
  final String title;
  final String description;
  final String? imageUrl;
  PostEntity({
    required this.title,
    required this.description,
    this.imageUrl,
  });
}
