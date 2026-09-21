import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class WatchlistState {
  final UiState<List<MovieModel>> moviesState;
  final bool isInWatchlist;

  const WatchlistState({
    this.moviesState = const UiState.initial(),
    this.isInWatchlist = false,
  });

  WatchlistState copyWith({
    UiState<List<MovieModel>>? moviesState,
    bool? isInWatchlist,
  }) {
    return WatchlistState(
      moviesState: moviesState ?? this.moviesState,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
    );
  }
}
