import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/home/home.state.dart';
import 'package:watchlist_project/features/presentation/bloc/home/home_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/home/home_event.dart';
import 'package:watchlist_project/features/presentation/pages/search_page.dart';
import 'watchlist_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const List<Widget> _pages = [
    WatchlistPage(),
    SearchPage(name: '', details: ''),
    Scaffold(
      body: Center(child: Text('Data / Dummy Page')),
    ),
    Scaffold(
      body: Center(child: Text('Chat / Dummy Page')),
    ),
    Scaffold(
      body: Center(child: Text('Profile / Dummy Page')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(child: _pages[state.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (idx) =>
                  context.read<HomeBloc>().add(HomeTabChanged(idx)),
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'Watchlist'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'Data'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}
