import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/state/ui_state.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home/presentation/bloc/home_bloc.dart';
import 'package:movies/features/home/presentation/bloc/home_state.dart';
import 'package:movies/shared/widgets/movie_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController pageController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: 0.45, initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void openMovieDetails(int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: movieId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final moviesState = state.moviesState;

        if (moviesState.status == UiStateStatus.loading ||
            moviesState.status == UiStateStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (moviesState.status == UiStateStatus.error) {
          return Center(
            child: Text(
              moviesState.errorMessage ?? 'Something went wrong',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (moviesState.status == UiStateStatus.empty ||
            moviesState.data == null ||
            moviesState.data!.isEmpty) {
          return const Center(child: Text('No movies found'));
        }

        final movies = moviesState.data!;

        return SingleChildScrollView(
          child: Column(
            children: [
              // Available Now
              Padding(
                padding: const EdgeInsets.only(right: 82, left: 81, top: 7),
                child: Image.asset(
                  AppAssets.available,
                  height: screenSize.height * .14,
                  width: screenSize.width * .62,
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 21),

              // Available Now Movies
              SizedBox(
                height: screenSize.height * .25,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: movies.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return AnimatedScale(
                      scale: currentIndex == index ? 1.0 : 0.78,
                      duration: const Duration(milliseconds: 200),
                      child: MovieCard(
                        imageUrl: movie.mediumCoverImage,
                        rating: movie.rating,
                        onTap: () {
                          openMovieDetails(movie.id);
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 21),

              // Watch Now
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Image.asset(
                  AppAssets.watchNow,
                  height: screenSize.height * .14,
                  width: screenSize.width * .62,
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 6),

              // Action Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text('Action', style: textTheme.titleLarge),
                    const Spacer(),
                    Text(
                      'See More',
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Action Movies
              SizedBox(
                height: screenSize.height * .20,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return MovieCard(
                      imageUrl: movie.mediumCoverImage,
                      rating: movie.rating,
                      onTap: () {
                        openMovieDetails(movie.id);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
