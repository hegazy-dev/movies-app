abstract class SearchEvent {}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  SearchMoviesEvent({required this.query});
}
