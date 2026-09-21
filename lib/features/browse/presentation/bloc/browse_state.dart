import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class BrowseState {
  final UiState<List<MovieModel>> moviesState;
  final Set<String> genres;
  final String selectedGenre;

  const BrowseState({
    this.moviesState = const UiState.initial(),
    this.genres = const {},
    this.selectedGenre = '',
  });

  BrowseState copyWith({
    UiState<List<MovieModel>>? moviesState,
    Set<String>? genres,
    String? selectedGenre,
  }) {
    return BrowseState(
      moviesState: moviesState ?? this.moviesState,
      genres: genres ?? this.genres,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
  }
}
