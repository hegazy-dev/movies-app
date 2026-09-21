import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';

class AvatarPicker extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedIndex,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: AppAssets.avatars.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onAvatarSelected(index),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                  width: isSelected ? 3 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.avatars[index]),
                  backgroundColor: const Color(0xFFB3E5FC),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
