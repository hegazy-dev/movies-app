import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/home/data/repositories/home_repository.dart';
import 'package:movies/features/home/presentation/bloc/home_event.dart';
import 'package:movies/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc({HomeRepository? repository})
    : _repository = repository ?? HomeRepository(),
      super(const HomeState()) {
    on<GetMoviesEvent>(_getMovies);
  }

  Future<void> _getMovies(GetMoviesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(moviesState: const UiState.loading()));

    try {
      final movies = await _repository.getMovies(
        limit: event.limit,
        page: event.page,
      );

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
