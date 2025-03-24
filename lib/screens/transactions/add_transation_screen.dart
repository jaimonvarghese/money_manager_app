import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category/category_db.dart';
import 'package:money_manager_app/db/transations/transation_db.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';
import 'package:money_manager_app/models/transations/transation_model.dart';

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

  final _purposeTextEditingControler = TextEditingController();
  final _amountTextEditingControler = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _purposeTextEditingControler,
                decoration: InputDecoration(
                  hintText: "Purpose",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _amountTextEditingControler,
                decoration: InputDecoration(
                  hintText: "Amount",
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
                            _categoryID = null;
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
                            _categoryID = null;
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
                            onTap: () {
                              _selectedCategoryModel = e;
                            },
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
              ElevatedButton(
                onPressed: () {
                  addTransation();
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransation() async {
    final _purpose = _purposeTextEditingControler.text;
    final _amount = _amountTextEditingControler.text;
    if (_purpose.isEmpty) {
      return;
    }
    if (_amount.isEmpty) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amount);
    if (_parsedAmount == null) {
      return;
    }
    //_selectedDate
    //_selectedCategoryType
    //_categoryID
    final _model = TransationModel(
      purpose: _purpose,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );

   await TransationDb.instance.addTransation(_model);
   Navigator.of(context).pop();
   TransationDb.instance.refresh();
  }
}
