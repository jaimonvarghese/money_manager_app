import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/category/category_db.dart';
import 'package:money_manager_app/db/transations/transation_db.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransationDb.instance.transationListNotifier,
      builder: (context, newList, _) {
        return ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final _values = newList[index];
            return Slidable(
              key: Key(_values.id!),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransationDb.instance.deleteTransations(_values.id!);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        _values.type == CategoryType.income
                            ? Colors.green
                            : Colors.yellow,
                    radius: 30,
                    child: Text(
                      parseDate(_values.date),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text("RS ${_values.amount}"),
                  subtitle: Text(_values.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) => SizedBox(height: 10),
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last} \n ${_splitedDate.first}';
  }
}
