import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/repositories/home_repository.dart';
import 'package:movies/features/browse/presentation/bloc/browse_event.dart';
import 'package:movies/features/browse/presentation/bloc/browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final HomeRepository _repository;

  BrowseBloc({HomeRepository? repository})
    : _repository = repository ?? HomeRepository(),
      super(const BrowseState()) {
    on<GetBrowseMoviesEvent>(_getBrowseMovies);
  }

  Future<void> _getBrowseMovies(
    GetBrowseMoviesEvent event,
    Emitter<BrowseState> emit,
  ) async {
    emit(state.copyWith(moviesState: const UiState.loading()));

    try {
      final movies = await _repository.getMovies();

      if (movies.isEmpty) {
        emit(
          state.copyWith(moviesState: const UiState.empty(), genres: const {}),
        );
        return;
      }

      final Set<String> genres = {};

      for (final movie in movies) {
        genres.addAll(movie.genres);
      }

      emit(
        state.copyWith(
          moviesState: UiState.success(movies),
          genres: genres,
          selectedGenre: genres.isNotEmpty ? genres.first : '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }
}
