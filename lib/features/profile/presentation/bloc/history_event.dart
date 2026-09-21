import 'package:movies/features/home/data/models/movie_model.dart';

abstract class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {
  final String userId;

  GetHistoryEvent({required this.userId});
}

class AddToHistoryEvent extends HistoryEvent {
  final String userId;
  final MovieModel movie;

  AddToHistoryEvent({required this.userId, required this.movie});
}

class RemoveFromHistoryEvent extends HistoryEvent {
  final String userId;
  final int movieId;

  RemoveFromHistoryEvent({required this.userId, required this.movieId});
}

class ClearHistoryEvent extends HistoryEvent {
  final String userId;

  ClearHistoryEvent({required this.userId});
}
