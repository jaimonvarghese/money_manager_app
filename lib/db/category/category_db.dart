import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFuctions {
  Future<List<CateegoryModel>> getCategories();
  Future<void> insertCategory(CateegoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDb implements CategoryDbFuctions {

  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb(){
    return instance;
  }



  ValueNotifier<List<CateegoryModel>> incomeCategoryListNotifier = ValueNotifier([]);
  ValueNotifier<List<CateegoryModel>> expenseCategoryListNotifier = ValueNotifier([]);
  @override
  Future<void> insertCategory(CateegoryModel value) async {
    final _categoryDb = await Hive.openBox<CateegoryModel>(CATEGORY_DB_NAME);
    _categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CateegoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CateegoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    await Future.forEach(_allCategories, (CateegoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(category);
      } else {
        expenseCategoryListNotifier.value.add(category);
      }
    });
    incomeCategoryListNotifier.notifyListeners();
    expenseCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async{
    final _categoryDb = await Hive.openBox<CateegoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.delete(categoryID);
    refreshUI();
  }
}
