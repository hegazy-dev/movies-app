import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_colors.dart';

class ActiveNavBarIcon extends StatelessWidget {
  final String iconName;

  const ActiveNavBarIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 33),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset(
        'assets/icons/$iconName.svg',
        width: 22,
        height: 22,
        fit: BoxFit.scaleDown,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
    );
  }
}
