import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/auth/presentation/screens/login_screen.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding1.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding2.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding3.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding4.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding5.dart';
import 'package:movies/features/onboarding/presentation/screens/on_boarding6.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  static const int _pageCount = 6;

  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Onboarding Pages
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: [
              OnboardingPage1(onNext: _goToNextPage),

              OnboardingPage2(onNext: _goToNextPage),

              OnboardingPage3(onNext: _goToNextPage, onBack: _goToPreviousPage),

              OnboardingPage4(onNext: _goToNextPage, onBack: _goToPreviousPage),

              OnboardingPage5(onNext: _goToNextPage, onBack: _goToPreviousPage),

              OnboardingPage6(
                onNext: _finishOnboarding,
                onBack: _goToPreviousPage,
              ),
            ],
          ),

          // Page Indicator
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pageCount, (index) {
                final bool isActive = _currentPage == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: isActive ? 20 : 6,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.white24,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
