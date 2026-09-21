import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_button.dart';

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingPage3({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/OnBoarding3.png',
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
                      'Explore All Genres',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textTheme.headlineMedium,
                    ),

                    const SizedBox(height: 15),

                    // Description
                    Text(
                      'Discover movies from every genre, in all '
                      'available qualities. Find something new '
                      'and exciting to watch every day.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textTheme.titleMedium,
                    ),

                    const SizedBox(height: 25),

                    // Next Button
                    OnboardingButton(text: 'Next', onPressed: onNext),

                    const SizedBox(height: 20),

                    // Back Button
                    SizedBox(
                      width: double.infinity,
                      height: 65,
                      child: OutlinedButton(
                        onPressed: onBack,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Back',
                          style: AppTextStyles.textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

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
