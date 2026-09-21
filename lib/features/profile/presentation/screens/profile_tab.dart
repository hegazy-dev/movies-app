import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/core/state/ui_state.dart';

import 'package:movies/features/auth/presentation/screens/login_screen.dart';

import 'package:movies/features/profile/presentation/bloc/history_bloc.dart';
import 'package:movies/features/profile/presentation/bloc/history_event.dart';
import 'package:movies/features/profile/presentation/bloc/history_state.dart';

import 'package:movies/features/profile/presentation/bloc/watchlist_bloc.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_event.dart';
import 'package:movies/features/profile/presentation/bloc/watchlist_state.dart';

import 'package:movies/features/profile/presentation/screens/update_profile_screen.dart';

import 'package:movies/features/profile/presentation/widgets/empty_watchlist.dart';
import 'package:movies/features/profile/presentation/widgets/movie_grid.dart';
import 'package:movies/features/profile/presentation/widgets/profile_action_buttons.dart';
import 'package:movies/features/profile/presentation/widgets/profile_header.dart';
import 'package:movies/features/profile/presentation/widgets/profile_tabs.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text(
          'Please login first',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              WatchlistBloc()..add(GetWatchlistEvent(userId: user.uid)),
        ),
        BlocProvider(
          create: (_) => HistoryBloc()..add(GetHistoryEvent(userId: user.uid)),
        ),
      ],
      child: const _ProfileTabView(),
    );
  }
}

class _ProfileTabView extends StatefulWidget {
  const _ProfileTabView();

  @override
  State<_ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<_ProfileTabView> {
  int _selectedTab = 0;

  final String _userName = 'John Safwat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, watchlistState) {
                return BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, historyState) {
                    final watchlistCount =
                        watchlistState.moviesState.data?.length ?? 0;

                    final historyCount =
                        historyState.moviesState.data?.length ?? 0;

                    return ProfileHeader(
                      userName: _userName,
                      wishListCount: watchlistCount,
                      historyCount: historyCount,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            ProfileActionButtons(
              onEditProfile: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen(),
                  ),
                );
              },
              onExit: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),

            const SizedBox(height: 20),

            ProfileTabs(
              selectedIndex: _selectedTab,
              onTabChanged: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            ),

            Expanded(
              child: _selectedTab == 0 ? _buildWatchlist() : _buildHistory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlist() {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        switch (state.moviesState.status) {
          case UiStateStatus.initial:
          case UiStateStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case UiStateStatus.empty:
            return const EmptyWatchlist();

          case UiStateStatus.error:
            return Center(
              child: Text(
                state.moviesState.errorMessage ?? 'Something went wrong',
                style: const TextStyle(color: Colors.white),
              ),
            );

          case UiStateStatus.success:
            final movies = state.moviesState.data!;

            return MovieGrid(movies: movies);
        }
      },
    );
  }

  Widget _buildHistory() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        switch (state.moviesState.status) {
          case UiStateStatus.initial:
          case UiStateStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case UiStateStatus.empty:
            return const EmptyWatchlist();

          case UiStateStatus.error:
            return Center(
              child: Text(
                state.moviesState.errorMessage ?? 'Something went wrong',
                style: const TextStyle(color: Colors.white),
              ),
            );

          case UiStateStatus.success:
            final movies = state.moviesState.data!;

            return MovieGrid(movies: movies);
        }
      },
    );
  }
}
