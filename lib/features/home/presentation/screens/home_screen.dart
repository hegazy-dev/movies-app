import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/features/browse/presentation/screens/browse_tab.dart';
import 'package:movies/features/home/presentation/bloc/home_bloc.dart';
import 'package:movies/features/home/presentation/bloc/home_event.dart';
import 'package:movies/features/home/presentation/screens/home_tab.dart';
import 'package:movies/features/profile/presentation/screens/profile_tab.dart';
import 'package:movies/features/search/presentation/screens/search_tab.dart';

import 'package:movies/shared/widgets/active_nav_bar_icon.dart';
import 'package:movies/shared/widgets/inactive_nav_bar_icon.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> tabs = const [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(GetMoviesEvent(limit: 20)),
      child: Scaffold(
        body: SafeArea(child: tabs[currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: InactiveNavBarIcon(iconName: 'home'),
              activeIcon: ActiveNavBarIcon(iconName: 'home'),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: InactiveNavBarIcon(iconName: 'search'),
              activeIcon: ActiveNavBarIcon(iconName: 'search'),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: InactiveNavBarIcon(iconName: 'explore'),
              activeIcon: ActiveNavBarIcon(iconName: 'explore'),
              label: 'explore',
            ),
            BottomNavigationBarItem(
              icon: InactiveNavBarIcon(iconName: 'profile'),
              activeIcon: ActiveNavBarIcon(iconName: 'profile'),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
