import 'package:movies/features/home/data/models/movie_model.dart';

abstract class WatchlistEvent {}

class GetWatchlistEvent extends WatchlistEvent {
  final String userId;

  GetWatchlistEvent({required this.userId});
}

class AddToWatchlistEvent extends WatchlistEvent {
  final String userId;
  final MovieModel movie;

  AddToWatchlistEvent({required this.userId, required this.movie});
}

class RemoveFromWatchlistEvent extends WatchlistEvent {
  final String userId;
  final int movieId;

  RemoveFromWatchlistEvent({required this.userId, required this.movieId});
}

class CheckWatchlistEvent extends WatchlistEvent {
  final String userId;
  final int movieId;

  CheckWatchlistEvent({required this.userId, required this.movieId});
}
