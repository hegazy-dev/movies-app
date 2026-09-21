import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_assets.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final PageController _pageController = PageController(
    viewportFraction: 0.30,
    initialPage: 1,
  );

  int selectedIndex = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: AppAssets.avatars.length,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final bool isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedScale(
                  scale: isSelected ? 1.0 : 0.62,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.avatars[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 2),

        const Text("Avatar"),
      ],
    );
  }
}
