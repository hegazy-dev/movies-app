import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';
import 'package:movies/features/home/data/repositories/home_repository.dart';
import 'package:movies/features/search/presentation/bloc/search_event.dart';
import 'package:movies/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeRepository _repository;

  SearchBloc({HomeRepository? repository})
    : _repository = repository ?? HomeRepository(),
      super(const SearchState()) {
    on<SearchMoviesEvent>(_searchMovies);
  }

  Future<void> _searchMovies(
    SearchMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(moviesState: const UiState.initial()));
      return;
    }

    emit(state.copyWith(moviesState: const UiState.loading()));

    try {
      final movies = await _repository.searchMovies(query: event.query.trim());

      if (movies.isEmpty) {
        emit(state.copyWith(moviesState: const UiState.empty()));
        return;
      }

      emit(state.copyWith(moviesState: UiState.success(movies)));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }
}
