import 'package:movies/features/home/data/models/movie_model.dart';
import 'package:movies/features/profile/data/data_sources/history_data_source.dart';

class HistoryRepository {
  final HistoryDataSource _dataSource;

  HistoryRepository({HistoryDataSource? dataSource})
    : _dataSource = dataSource ?? HistoryDataSource();

  Future<void> addToHistory({
    required String userId,
    required MovieModel movie,
  }) {
    return _dataSource.addToHistory(userId: userId, movie: movie);
  }

  Future<List<MovieModel>> getHistory({required String userId}) {
    return _dataSource.getHistory(userId: userId);
  }

  Future<void> removeFromHistory({
    required String userId,
    required int movieId,
  }) {
    return _dataSource.removeFromHistory(userId: userId, movieId: movieId);
  }

  Future<void> clearHistory({required String userId}) {
    return _dataSource.clearHistory(userId: userId);
  }
}
