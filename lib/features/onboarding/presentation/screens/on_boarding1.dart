import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_button.dart';

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingPage1({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/OnBoarding1.png',
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                  stops: const [0.45, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            left: 25,
            right: 25,
            bottom: 35,
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const Text(
                    'Find Your Next\nFavorite Movie Here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Get access to a huge library of movies\n'
                    'to suit all tastes. You will surely like it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  OnboardingButton(text: 'Explore Now', onPressed: onNext),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
