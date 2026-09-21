abstract class HomeEvent {}

class GetMoviesEvent extends HomeEvent {
  final int limit;
  final int page;

  GetMoviesEvent({this.limit = 20, this.page = 1});
}
