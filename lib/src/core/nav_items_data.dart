import 'package:campus_navigation_system/src/screens/announcements.dart';
import 'package:campus_navigation_system/src/screens/event_calendar.dart';
import 'package:campus_navigation_system/src/screens/home_page.dart';
import 'package:campus_navigation_system/src/screens/settings.dart';
import 'package:flutter/material.dart';

final List<Widget> navItems = [
  HomePage(),
  EventCalendar(),
  AnnouncementsScreen(),
  SettingsScreen(),
];

const bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    label: 'Events',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.announcement),
    label: 'Announcements',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  ),
];
