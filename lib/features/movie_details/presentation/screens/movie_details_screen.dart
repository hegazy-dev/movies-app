import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/core/state/ui_state.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';

import 'package:movies/features/home/data/models/movie_model.dart';

import 'package:movies/features/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:movies/features/movie_details/presentation/bloc/movie_details_event.dart';
import 'package:movies/features/movie_details/presentation/bloc/movie_details_state.dart';

import 'package:movies/features/profile/presentation/bloc/history_bloc.dart';
import 'package:movies/features/profile/presentation/bloc/history_event.dart';

import 'package:movies/features/profile/presentation/bloc/watchlist_bloc.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_event.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/movie-details';

  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieDetailsBloc()..add(GetMovieDetailsEvent(movieId)),
        ),

        BlocProvider(
          create: (_) =>
              WatchlistBloc()
                ..add(CheckWatchlistEvent(userId: user!.uid, movieId: movieId)),
        ),

        BlocProvider(create: (_) => HistoryBloc()),
      ],
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          final movieState = state.movieState;

          switch (movieState.status) {
            case UiStateStatus.initial:
            case UiStateStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );

            case UiStateStatus.error:
              return Center(
                child: Text(
                  movieState.errorMessage ?? 'Something went wrong',
                  style: AppTextStyles.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );

            case UiStateStatus.empty:
              return Center(
                child: Text(
                  'No movie details found',
                  style: AppTextStyles.textTheme.bodyLarge,
                ),
              );

            case UiStateStatus.success:
              final movie = movieState.data!;

              // Add the visited movie to History.
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                context.read<HistoryBloc>().add(
                  AddToHistoryEvent(
                    userId: user.uid,
                    movie: MovieModel(
                      id: movie.id,
                      title: movie.title,
                      rating: movie.rating,
                      mediumCoverImage: movie.largeCoverImage,
                      largeCoverImage: movie.largeCoverImage,
                      genres: movie.genres,
                      year: movie.year,
                    ),
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _MovieHeader(
                      movieId: movie.id,
                      backgroundImage: movie.backgroundImage,
                      title: movie.title,
                      year: movie.year,
                      largeCoverImage: movie.largeCoverImage,
                      genres: movie.genres,
                      rating: movie.rating,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 18),

                          _WatchButton(
                            onPressed: () {
                              // TODO: Open trailer or watch action.
                            },
                          ),

                          const SizedBox(height: 14),

                          _MovieStats(
                            runtime: movie.runtime,
                            rating: movie.rating,
                          ),

                          const SizedBox(height: 26),

                          const _SectionTitle(title: 'Screen Shots'),

                          const SizedBox(height: 12),

                          _ScreenshotsList(screenshots: movie.screenshots),

                          const SizedBox(height: 26),

                          const _SectionTitle(title: 'Genres'),

                          const SizedBox(height: 12),

                          _GenresList(genres: movie.genres),

                          const SizedBox(height: 26),

                          const _SectionTitle(title: 'Description'),

                          const SizedBox(height: 12),

                          Text(
                            movie.description.isEmpty
                                ? 'No description available'
                                : movie.description,
                            style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class _MovieHeader extends StatelessWidget {
  final int movieId;
  final String backgroundImage;
  final String title;
  final int year;
  final String largeCoverImage;
  final List<String> genres;
  final double rating;

  const _MovieHeader({
    required this.movieId,
    required this.backgroundImage,
    required this.title,
    required this.year,
    required this.largeCoverImage,
    required this.genres,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final movie = MovieModel(
      id: movieId,
      title: title,
      rating: rating,
      mediumCoverImage: largeCoverImage,
      largeCoverImage: largeCoverImage,
      genres: genres,
      year: year,
    );

    return SizedBox(
      height: 560,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            backgroundImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(largeCoverImage, fit: BoxFit.cover);
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.35),
                  AppColors.background.withValues(alpha: 0.98),
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),

          Positioned(
            top: 42,
            left: 14,
            child: _CircleIconButton(
              icon: Icons.arrow_back_ios_new,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          Positioned(
            top: 42,
            right: 14,
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                return _CircleIconButton(
                  icon: state.isInWatchlist
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user == null) {
                      return;
                    }

                    if (state.isInWatchlist) {
                      context.read<WatchlistBloc>().add(
                        RemoveFromWatchlistEvent(
                          userId: user.uid,
                          movieId: movie.id,
                        ),
                      );
                    } else {
                      context.read<WatchlistBloc>().add(
                        AddToWatchlistEvent(userId: user.uid, movie: movie),
                      );
                    }
                  },
                );
              },
            ),
          ),

          Center(
            child: _PlayButton(
              onPressed: () {
                // TODO: Open movie trailer.
              },
            ),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 22,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  '$year',
                  style: AppTextStyles.textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.35),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _PlayButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5),
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 42),
        ),
      ),
    );
  }
}

class _WatchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _WatchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          'Watch',
          style: AppTextStyles.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _MovieStats extends StatelessWidget {
  final int runtime;
  final double rating;

  const _MovieStats({required this.runtime, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(icon: Icons.favorite, value: '15'),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _StatItem(icon: Icons.access_time_filled, value: '$runtime'),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _StatItem(icon: Icons.star, value: rating.toStringAsFixed(1)),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 23),

          const SizedBox(width: 10),

          Text(
            value,
            style: AppTextStyles.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ScreenshotsList extends StatelessWidget {
  final List<String> screenshots;

  const _ScreenshotsList({required this.screenshots});

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) {
      return const Text(
        'No screenshots available',
        style: TextStyle(color: Colors.white70),
      );
    }

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              screenshots[index],
              width: 250,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 250,
                  height: 150,
                  color: const Color(0xFF252525),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.white54),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _GenresList extends StatelessWidget {
  final List<String> genres;

  const _GenresList({required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            genre,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        );
      }).toList(),
    );
  }
}
