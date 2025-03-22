import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/category/catergory_screen.dart';
import 'package:money_manager_app/screens/home/widgets/money_manager_bottom_navigation.dart';
import 'package:money_manager_app/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [TransactionScreen(), CatergoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add tranction');
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
    );
  }
}
