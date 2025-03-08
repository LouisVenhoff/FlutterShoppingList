import 'package:flutter/material.dart';
import 'package:shopping_list/pages/shoppingList.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingList(),
    );
  }
}
