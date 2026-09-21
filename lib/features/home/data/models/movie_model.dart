class MovieModel {
  final int id;
  final String title;
  final double rating;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> genres;
  final int year;

  const MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.genres,
    required this.year,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      rating: (json['rating'] as num).toDouble(),
      mediumCoverImage: json['medium_cover_image'] as String,
      largeCoverImage: json['large_cover_image'] as String,
      genres: List<String>.from(json['genres'] as List),
      year: json['year'] as int,
    );
  }
}
