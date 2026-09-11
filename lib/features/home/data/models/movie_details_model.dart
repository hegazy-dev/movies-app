class MovieDetailsModel {
  final int id;
  final String title;
  final String description;
  final double rating;
  final int runtime;
  final int year;
  final List<String> genres;
  final String largeCoverImage;
  final String backgroundImage;
  final String? trailerCode;

  const MovieDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.runtime,
    required this.year,
    required this.genres,
    required this.largeCoverImage,
    required this.backgroundImage,
    this.trailerCode,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: (json['description_full'] as String?) ?? '',
      rating: (json['rating'] as num).toDouble(),
      runtime: json['runtime'] as int,
      year: json['year'] as int,
      genres: List<String>.from(json['genres'] as List),
      largeCoverImage: json['large_cover_image'] as String,
      backgroundImage: json['background_image'] as String,
      trailerCode: json['yt_trailer_code'] as String?,
    );
  }
}
