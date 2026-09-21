import 'package:movies/core/network/api_client.dart';
import 'package:movies/features/movie_details/data/models/movie_details_model.dart';

class MovieDetailsDataSource {
  final ApiClient _apiClient;

  MovieDetailsDataSource({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await _apiClient.get(
      'movie_details.json',
      queryParameters: {'movie_id': movieId},
    );

    final movieJson = response['data']['movie'] as Map<String, dynamic>;

    return MovieDetailsModel.fromJson(movieJson);
  }
}
