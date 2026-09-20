import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/core/state/ui_state.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home/data/models/movie_model.dart';
import 'package:movies/features/search/presentation/bloc/search_bloc.dart';
import 'package:movies/features/search/presentation/bloc/search_event.dart';
import 'package:movies/features/search/presentation/bloc/search_state.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SearchBloc(), child: const SearchView());
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      context.read<SearchBloc>().add(SearchMoviesEvent(query: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .015),

              const Text(
                'Search',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),

              const SizedBox(height: 12),

              _buildSearchField(),

              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    final moviesState = state.moviesState;

                    if (moviesState.status == UiStateStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (moviesState.status == UiStateStatus.error) {
                      return Center(
                        child: Text(
                          'Something went wrong',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (moviesState.status == UiStateStatus.empty) {
                      return const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    }

                    if (moviesState.status == UiStateStatus.success) {
                      final movies = moviesState.data ?? [];

                      return _buildMoviesGrid(movies);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: 'Search for a movie',
          hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
          prefixIcon: Icon(Icons.search, color: Colors.white, size: 22),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildMoviesGrid(List<MovieModel> movies) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 0, bottom: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: .68,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return _MovieSearchCard(movie: movies[index]);
      },
    );
  }
}

class _MovieSearchCard extends StatelessWidget {
  final MovieModel movie;

  const _MovieSearchCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.mediumCoverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF242424),
                child: const Icon(
                  Icons.movie_outlined,
                  color: Colors.white54,
                  size: 40,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: const Color(0xFF242424),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
          ),

          Positioned(
            top: 6,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.65),
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
                  const Icon(Icons.star, color: Colors.amber, size: 13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
