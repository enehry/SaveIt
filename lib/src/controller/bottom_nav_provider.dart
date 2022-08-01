import 'package:flutter/material.dart';
import 'package:save_it/src/pages/challenges/challenges_page.dart';
import 'package:save_it/src/pages/savings_allocation/savings_allocation.dart';
import 'package:save_it/src/pages/settings/settings_page.dart';

class BottomNavProvider with ChangeNotifier {
  // list of pages
  final List<dynamic> _pages = [
    const ChallengesPage(),
    const SavingsAllocation(),
    const SettingsPage(),
  ];

  // current page index
  int _currentIndex = 0;
  // getter for current page
  Widget get currentPage => _pages[_currentIndex];

  // getter for current page title
  String? get pageTitle => _pages[_currentIndex].title;

  // getter for current page index
  int get currentIndex => _currentIndex;

  // setter for current page index
  set currentIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }
}
