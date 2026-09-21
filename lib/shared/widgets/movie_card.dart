import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: AppColors.primary, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
