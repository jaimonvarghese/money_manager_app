import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/home/home_screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (context, updatedIndex, _) {
        return  BottomNavigationBar(
          elevation: 1,
          backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          HomeScreen.selectedIndexNotifier.value = newIndex;
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category")
      ]);
      },
    );
  }
}