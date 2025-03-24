import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';
 part 'transation_model.g.dart';
@HiveType(typeId: 3)
class TransationModel {

  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final CateegoryModel category;

  @HiveField(5)
  String? id;

  TransationModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }){
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
