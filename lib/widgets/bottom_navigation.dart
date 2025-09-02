import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final List<Widget> screens;

  const BottomNavigation({super.key, required this.screens});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: onDestinationSelected,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.list_rounded),
            label: 'Список персонажей',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_rounded),
            label: 'Избранное',
          ),
        ],
      ),
      body: widget.screens[currentPageIndex],
    );
  }
}
