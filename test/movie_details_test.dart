import 'package:flutter_test/flutter_test.dart';
import 'package:movies/features/home/data/data_sources/home_data_source.dart';

void main() {
  test('Get movie details from API', () async {
    final dataSource = HomeDataSource();

    final movie = await dataSource.getMovieDetails(78477);

    expect(movie.id, isA<int>());
    expect(movie.title, isA<String>());
    expect(movie.rating, isA<double>());
    expect(movie.year, isA<int>());
    expect(movie.runtime, isA<int>());
    expect(movie.genres, isNotEmpty);
    expect(movie.largeCoverImage, isNotEmpty);
    expect(movie.backgroundImage, isNotEmpty);

    print('Movie ID: ${movie.id}');
    print('Movie title: ${movie.title}');
    print('Rating: ${movie.rating}');
    print('Year: ${movie.year}');
    print('Runtime: ${movie.runtime}');
  });
}
