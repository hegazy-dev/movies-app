import 'package:movies/features/movie_details/data/data_source/movie_details_data_source.dart';
import 'package:movies/features/movie_details/data/models/movie_details_model.dart';

class MovieDetailsRepository {
  final MovieDetailsDataSource _dataSource;

  MovieDetailsRepository({MovieDetailsDataSource? dataSource})
    : _dataSource = dataSource ?? MovieDetailsDataSource();

  Future<MovieDetailsModel> getMovieDetails(int movieId) {
    return _dataSource.getMovieDetails(movieId);
  }
}
