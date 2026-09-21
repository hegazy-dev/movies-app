import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class SearchState {
  final UiState<List<MovieModel>> moviesState;

  const SearchState({this.moviesState = const UiState.initial()});

  SearchState copyWith({UiState<List<MovieModel>>? moviesState}) {
    return SearchState(moviesState: moviesState ?? this.moviesState);
  }
}
