import 'package:movies/core/network/api_client.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class HomeDataSource {
  final ApiClient _apiClient;

  HomeDataSource({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<List<MovieModel>> getMovies({int limit = 20, int page = 1}) async {
    final response = await _apiClient.get(
      'list_movies.json',
      queryParameters: {'limit': limit, 'page': page},
    );

    final moviesJson = response['data']['movies'] as List;

    return moviesJson
        .map(
          (movieJson) => MovieModel.fromJson(movieJson as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<MovieModel>> searchMovies({
    required String query,
    int limit = 20,
    int page = 1,
  }) async {
    final response = await _apiClient.get(
      'list_movies.json',
      queryParameters: {'query_term': query, 'limit': limit, 'page': page},
    );

    final moviesJson = response['data']['movies'] as List?;

    if (moviesJson == null) {
      return [];
    }

    return moviesJson
        .map(
          (movieJson) => MovieModel.fromJson(movieJson as Map<String, dynamic>),
        )
        .toList();
  }
}
