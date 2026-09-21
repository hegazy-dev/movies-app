import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/profile/data/repositories/watchlist_repository.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_event.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository _repository;

  WatchlistBloc({WatchlistRepository? repository})
    : _repository = repository ?? WatchlistRepository(),
      super(const WatchlistState()) {
    on<GetWatchlistEvent>(_getWatchlist);
    on<AddToWatchlistEvent>(_addToWatchlist);
    on<RemoveFromWatchlistEvent>(_removeFromWatchlist);
    on<CheckWatchlistEvent>(_checkWatchlist);
  }

  Future<void> _getWatchlist(
    GetWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(moviesState: const UiState.loading()));

    try {
      final movies = await _repository.getWatchlist(userId: event.userId);

      if (movies.isEmpty) {
        emit(state.copyWith(moviesState: const UiState.empty()));
        return;
      }

      emit(state.copyWith(moviesState: UiState.success(movies)));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _addToWatchlist(
    AddToWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    try {
      await _repository.addToWatchlist(
        userId: event.userId,
        movie: event.movie,
      );

      emit(state.copyWith(isInWatchlist: true));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _removeFromWatchlist(
    RemoveFromWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    try {
      await _repository.removeFromWatchlist(
        userId: event.userId,
        movieId: event.movieId,
      );

      emit(state.copyWith(isInWatchlist: false));

      add(GetWatchlistEvent(userId: event.userId));
    } catch (e) {
      emit(state.copyWith(moviesState: UiState.error(e.toString())));
    }
  }

  Future<void> _checkWatchlist(
    CheckWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    try {
      final isInWatchlist = await _repository.isInWatchlist(
        userId: event.userId,
        movieId: event.movieId,
      );

      emit(state.copyWith(isInWatchlist: isInWatchlist));
    } catch (e) {
      emit(state.copyWith(isInWatchlist: false));
    }
  }
}
