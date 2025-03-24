import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/models/transations/transation_model.dart';

const TRANSATION_DB_NAME = "transation-db";

abstract class TransationDbFunctions {
  Future<void> addTransation(TransationModel obj);
  Future<List<TransationModel>> getAllTransations();
  Future<void> deleteTransations( String id);
}

class TransationDb implements TransationDbFunctions {
  TransationDb._internal();
  static TransationDb instance = TransationDb._internal();

  factory TransationDb() {
    return instance;
  }

  ValueNotifier<List<TransationModel>> transationListNotifier = ValueNotifier(
    [],
  );

  @override
  Future<void> addTransation(TransationModel obj) async {
    final _transationDb = await Hive.openBox<TransationModel>(
      TRANSATION_DB_NAME,
    );
    await _transationDb.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransations();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transationListNotifier.value.clear();
    transationListNotifier.value.addAll(_list);
    transationListNotifier.notifyListeners();
  }

  @override
  Future<List<TransationModel>> getAllTransations() async {
    final _transationDb = await Hive.openBox<TransationModel>(
      TRANSATION_DB_NAME,
    );
    return _transationDb.values.toList();
  }
  
  @override
  Future<void> deleteTransations(String id)async {
    final _transationDb = await Hive.openBox<TransationModel>(
      TRANSATION_DB_NAME,
    );
    await _transationDb.delete(id);
    refresh();
  }
}
