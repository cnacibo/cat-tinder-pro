import 'package:flutter/material.dart';
import 'cats/cats_screen.dart';
import 'breeds/breeds_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const CatsScreen(), const BreedsScreen()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.pets), label: 'Cats'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Breeds'),
        ],
      ),
    );
  }
}