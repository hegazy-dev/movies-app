import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class HistoryState {
  final UiState<List<MovieModel>> moviesState;

  const HistoryState({this.moviesState = const UiState.initial()});

  HistoryState copyWith({UiState<List<MovieModel>>? moviesState}) {
    return HistoryState(moviesState: moviesState ?? this.moviesState);
  }
}
