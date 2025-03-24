import 'package:hive_flutter/hive_flutter.dart';
 part 'cateegory_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType { 

  @HiveField(1)
  income,

  @HiveField(2)
  expense,
}


@HiveType(typeId:1)
class CateegoryModel {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  CateegoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
}
