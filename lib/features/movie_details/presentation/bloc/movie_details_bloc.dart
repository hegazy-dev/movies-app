import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/movie_details/data/repositories/movie_details_repository.dart';
import 'package:movies/features/movie_details/presentation/bloc/movie_details_event.dart';
import 'package:movies/features/movie_details/presentation/bloc/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository _repository;

  MovieDetailsBloc({MovieDetailsRepository? repository})
    : _repository = repository ?? MovieDetailsRepository(),
      super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }

  Future<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(movieState: const UiState.loading()));

    try {
      final movie = await _repository.getMovieDetails(event.movieId);

      emit(state.copyWith(movieState: UiState.success(movie)));
    } catch (e) {
      emit(state.copyWith(movieState: UiState.error(e.toString())));
    }
  }
}
