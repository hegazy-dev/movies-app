import 'package:flutter/material.dart';
import 'package:movies/features/home/data/models/movie_model.dart';
import 'package:movies/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:movies/features/profile/presentation/widgets/movie_poster_card.dart';

class MovieGrid extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MoviePosterCard(
          movieId: movie.id,
          title: movie.title,
          rating: movie.rating,
          imageUrl: movie.mediumCoverImage,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsScreen(movieId: movie.id),
              ),
            );
          },
        );
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) return 2;
    if (width < 600) return 3;
    if (width < 900) return 4;

    return 5;
  }
}
