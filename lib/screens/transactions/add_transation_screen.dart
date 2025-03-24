import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category/category_db.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';

class AddTransationScreen extends StatelessWidget {
  const AddTransationScreen({super.key});

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
                onPressed: () {},
                label: Text("select date"),
                icon: Icon(Icons.calendar_today),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {},
                      ),
                      Text("Income"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: CategoryType.expense,
                        onChanged: (newValue) {},
                      ),
                      Text("Expense"),
                    ],
                  ),
                ],
              ),
              DropdownButton(
                hint: Text("Select Catergory"),
                items:
                    CategoryDb().expenseCategoryListNotifier.value.map((e) {
                      return DropdownMenuItem(value: e.id, child: Text(e.name));
                    }).toList(),
                onChanged: (selectedValue) {},
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
