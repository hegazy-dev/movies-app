import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class HomeState {
  final UiState<List<MovieModel>> moviesState;

  const HomeState({this.moviesState = const UiState.initial()});

  HomeState copyWith({UiState<List<MovieModel>>? moviesState}) {
    return HomeState(moviesState: moviesState ?? this.moviesState);
  }
}
