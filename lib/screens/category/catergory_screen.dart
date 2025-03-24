import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category/category_db.dart';
import 'package:money_manager_app/screens/category/expense_category_list.dart';
import 'package:money_manager_app/screens/category/income_category_list.dart';

class CatergoryScreen extends StatefulWidget {
  const CatergoryScreen({super.key});

  @override
  State<CatergoryScreen> createState() => _CatergoryScreenState();
}

class _CatergoryScreenState extends State<CatergoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: [Tab(text: 'INCOME'), Tab(text: 'EXPENSE')],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [IncomeCategoryList(),ExpenseCategoryList()],
          ),
        ),
      ],
    );
  }
}
