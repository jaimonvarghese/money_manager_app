import 'package:flutter/material.dart';
import 'package:money_manager_app/models/category/cateegory_model.dart';
import 'package:money_manager_app/models/transations/transation_model.dart';
import 'package:money_manager_app/screens/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CateegoryModelAdapter().typeId)) {
    Hive.registerAdapter(CateegoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransationModelAdapter().typeId)) {
    Hive.registerAdapter(TransationModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 73, 5, 190),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
