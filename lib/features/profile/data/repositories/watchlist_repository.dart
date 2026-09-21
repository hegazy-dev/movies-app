import 'package:movies/features/home/data/models/movie_model.dart';
import 'package:movies/features/profile/data/data_sources/watchlist_data_source.dart';

class WatchlistRepository {
  final WatchlistDataSource _dataSource;

  WatchlistRepository({WatchlistDataSource? dataSource})
    : _dataSource = dataSource ?? WatchlistDataSource();

  Future<void> addToWatchlist({
    required String userId,
    required MovieModel movie,
  }) {
    return _dataSource.addToWatchlist(userId: userId, movie: movie);
  }

  Future<void> removeFromWatchlist({
    required String userId,
    required int movieId,
  }) {
    return _dataSource.removeFromWatchlist(userId: userId, movieId: movieId);
  }

  Future<List<MovieModel>> getWatchlist({required String userId}) {
    return _dataSource.getWatchlist(userId: userId);
  }

  Future<bool> isInWatchlist({required String userId, required int movieId}) {
    return _dataSource.isInWatchlist(userId: userId, movieId: movieId);
  }
}
