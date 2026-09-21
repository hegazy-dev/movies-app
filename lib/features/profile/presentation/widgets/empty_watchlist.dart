import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class EmptyWatchlist extends StatelessWidget {
  const EmptyWatchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_filter,
            size: 100,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No movies yet',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your watchlist will appear here',
            style: TextStyle(
              color: AppColors.grey.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
