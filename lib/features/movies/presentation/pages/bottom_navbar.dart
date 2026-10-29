import 'package:flutter/material.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/pages/download_page.dart';
import 'package:netfilx/features/movies/presentation/pages/home_page.dart';
import 'package:netfilx/features/movies/presentation/pages/search_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    DownloadPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        backgroundColor: AppColors.background,

        selectedItemColor: AppColors.netflixRed,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            activeIcon: Icon(Icons.download),
            label: 'Downloads',
          ),
        ],
      ),
    );
  }
}