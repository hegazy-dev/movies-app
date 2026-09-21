import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_button.dart';

class OnboardingPage2 extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingPage2({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/OnBoarding2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Content
          Positioned(
            left: 0,
            right: 0,
            bottom: -20,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      'Discover Movies',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textTheme.headlineMedium,
                    ),

                    const SizedBox(height: 15),

                    // Description
                    Text(
                      'Explore a vast collection of movies in all\n'
                      'qualities and genres. Find your next\n'
                      'favorite film with ease.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textTheme.titleMedium,
                    ),

                    const SizedBox(height: 25),

                    // Next Button
                    OnboardingButton(text: 'Next', onPressed: onNext),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
