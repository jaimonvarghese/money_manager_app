import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text("date", textAlign: TextAlign.center),
            ),
            title: Text("10000"),
            subtitle: Text("travel"),
          ),
        );
      },
      separatorBuilder: (ctx, index) => SizedBox(height: 10),
      itemCount: 10,
    );
  }
}
