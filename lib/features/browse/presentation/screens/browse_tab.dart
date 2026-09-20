import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/features/browse/presentation/bloc/browse_bloc.dart';
import 'package:movies/features/browse/presentation/bloc/browse_event.dart';
import 'package:movies/features/browse/presentation/bloc/browse_state.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  String? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrowseBloc()..add(GetBrowseMoviesEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: SafeArea(
          child: BlocBuilder<BrowseBloc, BrowseState>(
            builder: (context, state) {
              final moviesState = state.moviesState;

              if (moviesState.status == UiStateStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFC107)),
                );
              }

              if (moviesState.status == UiStateStatus.error) {
                return const Center(
                  child: Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              if (moviesState.status == UiStateStatus.empty) {
                return const Center(
                  child: Text(
                    'No movies available',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              if (moviesState.status != UiStateStatus.success ||
                  moviesState.data == null) {
                return const SizedBox.shrink();
              }

              final List<MovieModel> movies = moviesState.data!;

              final List<String> genres = state.genres.toList();

              if (genres.isEmpty) {
                return const Center(
                  child: Text(
                    'No genres available',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              final String selectedGenre = _selectedGenre ?? genres.first;

              final List<MovieModel> filteredMovies = movies
                  .where((movie) => movie.genres.contains(selectedGenre))
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // =========================
                  // Genres
                  // =========================
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 6),
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        final isSelected = genre == selectedGenre;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGenre = genre;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFF101010),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFFFC107),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : const Color(0xFFFFC107),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // =========================
                  // Movies
                  // =========================
                  Expanded(
                    child: filteredMovies.isEmpty
                        ? Center(
                            child: Text(
                              'No movies in $selectedGenre',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.57,
                                ),
                            itemCount: filteredMovies.length,
                            itemBuilder: (context, index) {
                              final movie = filteredMovies[index];

                              return _MovieCard(movie: movie);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final MovieModel movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // =========================
          // Movie Poster
          // =========================
          Image.network(
            movie.mediumCoverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF252525),
                child: const Center(
                  child: Icon(
                    Icons.movie_outlined,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: const Color(0xFF252525),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFC107),
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),

          // =========================
          // Rating
          // =========================
          Positioned(
            top: 8,
            left: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.star, color: Color(0xFFFFC107), size: 13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
