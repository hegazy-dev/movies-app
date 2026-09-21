import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final int wishListCount;
  final int historyCount;
  final String? avatarPath;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.wishListCount,
    required this.historyCount,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: MediaQuery.sizeOf(context).width * 0.15,
            backgroundColor: const Color(0xFFB3E5FC),
            backgroundImage: AssetImage(avatarPath ?? AppAssets.defaultAvatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: AppTextStyles.textTheme.titleLarge),
              ],
            ),
          ),
          _StatItem(count: wishListCount, label: 'Wish List'),
          const SizedBox(width: 20),
          _StatItem(count: historyCount, label: 'History'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: AppTextStyles.textTheme.headlineLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.textTheme.titleSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
