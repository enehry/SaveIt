import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/bottom_nav_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.white70,
        iconSize: 35,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.primary,
        selectedIndex: context.watch<BottomNavProvider>().currentIndex,
        tabs: const [
          GButton(
            icon: Icons.pending_actions_outlined,
          ),
          GButton(
            icon: Icons.savings_outlined,
          ),
          GButton(
            icon: Icons.settings_outlined,
          ),
        ],
        onTabChange: (index) {
          context.read<BottomNavProvider>().currentIndex = index;
        },
      ),
    );
  }
}
