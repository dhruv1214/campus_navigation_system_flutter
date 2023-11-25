import 'package:campus_navigation_system/src/core/nav_items_data.dart';
import 'package:campus_navigation_system/src/core/theme_data.dart';
import 'package:flutter/material.dart';

class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key});

  final routeName = '/dashboard';

  @override
  State<StatefulWidget> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navItems[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 12,
          surfaceTintColor: navBarColor,
          color: navBarColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BottomNavigationBar(
                showSelectedLabels: false,
                useLegacyColorScheme: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                items: bottomNavigationBarItems),
          ),
        ),
      ),
    );
  }
}
