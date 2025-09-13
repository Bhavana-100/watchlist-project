import 'package:flutter/material.dart';
import 'package:watchlist_project/features/presentation/pages/search_page.dart';
import 'watchlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    WatchlistPage(),
    SearchPage(name: '', details: '',),
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
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}