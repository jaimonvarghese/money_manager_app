import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/category/category_add_popup.dart';
import 'package:money_manager_app/screens/category/catergory_screen.dart';
import 'package:money_manager_app/screens/home/widgets/money_manager_bottom_navigation.dart';
import 'package:money_manager_app/screens/transactions/add_transation_screen.dart';
import 'package:money_manager_app/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [TransactionScreen(), CatergoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      appBar: AppBar(
        title: Text(
          "Money Manager",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
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
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => AddTransationScreen()));
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
    );
  }
}
