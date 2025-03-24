import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category/category_db.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListNotifier,
      builder: (context, newList, child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = newList[index];
            return Card(
              color: const Color.fromARGB(255, 187, 204, 188),
              child: ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDb.instance.deleteCategory(category.id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(height: 10);
          },
          itemCount:newList.length,
        );
      },
    );
  }
}
