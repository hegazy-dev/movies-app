import 'package:movies/features/home/data/data_sources/home_data_source.dart';
import 'package:movies/features/movie_details/data/models/movie_details_model.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepository({HomeDataSource? dataSource})
    : _dataSource = dataSource ?? HomeDataSource();

  Future<List<MovieModel>> getMovies({int limit = 20, int page = 1}) {
    return _dataSource.getMovies(limit: limit, page: page);
  }
}
