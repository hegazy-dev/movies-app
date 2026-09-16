abstract class MovieDetailsEvent {}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetailsEvent(this.movieId);
}
