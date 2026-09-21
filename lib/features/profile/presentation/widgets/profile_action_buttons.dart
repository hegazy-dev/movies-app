import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onExit;

  const ProfileActionButtons({
    super.key,
    required this.onEditProfile,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onEditProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                fixedSize: Size(0, MediaQuery.sizeOf(context).height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onExit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                fixedSize: Size(0, MediaQuery.sizeOf(context).height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Exit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.logout, color: AppColors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
