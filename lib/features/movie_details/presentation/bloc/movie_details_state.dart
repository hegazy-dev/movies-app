import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/movie_details/data/models/movie_details_model.dart';

class MovieDetailsState {
  final UiState<MovieDetailsModel> movieState;

  const MovieDetailsState({this.movieState = const UiState.initial()});

  MovieDetailsState copyWith({UiState<MovieDetailsModel>? movieState}) {
    return MovieDetailsState(movieState: movieState ?? this.movieState);
  }
}
