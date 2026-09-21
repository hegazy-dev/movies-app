import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/profile/data/repositories/history_repository.dart';
import 'package:movies/features/profile/presentation/bloc/history_event.dart';
import 'package:movies/features/profile/presentation/bloc/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _repository;

  HistoryBloc({HistoryRepository? repository})
    : _repository = repository ?? HistoryRepository(),
      super(const HistoryState()) {
    on<GetHistoryEvent>(_getHistory);
    on<AddToHistoryEvent>(_addToHistory);
    on<RemoveFromHistoryEvent>(_removeFromHistory);
    on<ClearHistoryEvent>(_clearHistory);
  }

  Future<void> _getHistory(
    GetHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(moviesState: const UiState.loading()));

    try {
      final movies = await _repository.getHistory(userId: event.userId);

      if (movies.isEmpty) {
        emit(state.copyWith(moviesState: const UiState.empty()));
        return;
      }

      emit(state.copyWith(moviesState: UiState.success(movies)));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _addToHistory(
    AddToHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      await _repository.addToHistory(userId: event.userId, movie: event.movie);

      add(GetHistoryEvent(userId: event.userId));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _removeFromHistory(
    RemoveFromHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      await _repository.removeFromHistory(
        userId: event.userId,
        movieId: event.movieId,
      );

      add(GetHistoryEvent(userId: event.userId));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _clearHistory(
    ClearHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      await _repository.clearHistory(userId: event.userId);

      emit(state.copyWith(moviesState: const UiState.empty()));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }
}
