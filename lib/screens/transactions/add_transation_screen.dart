import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category/category_db.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';

class AddTransationScreen extends StatefulWidget {
  const AddTransationScreen({super.key});

  @override
  State<AddTransationScreen> createState() => _AddTransationScreenState();
}

class _AddTransationScreenState extends State<AddTransationScreen> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CateegoryModel? _selectedCategoryModel;

  String? _categoryID;

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(""),),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Purpose",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                label: Text(
                  _selectedDate == null
                      ? "select date"
                      : _selectedDate.toString(),
                ),
                icon: Icon(Icons.calendar_today),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID=null;
                          });
                        },
                      ),
                      Text("Income"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID=null;
                          });
                        },
                      ),
                      Text("Expense"),
                    ],
                  ),
                ],
              ),
              DropdownButton(
                hint: Text("Select Catergory"),
                value: _categoryID,
                items:
                    (_selectedCategoryType == CategoryType.income
                            ? CategoryDb().incomeCategoryListNotifier
                            : CategoryDb().expenseCategoryListNotifier)
                        .value
                        .map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                          );
                        })
                        .toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: () {}, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
