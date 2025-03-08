import 'package:flutter/material.dart';
import 'package:shopping_list/components/itemInput.dart';
import 'package:shopping_list/components/postItList.dart';

class ShoppingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(7, 94, 84, 1),
          title: const Text("Shopping List"),
        ),
        body: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 400, height: 700,child: PostItList()),
            ItemInput((String val) => print("Val: $val")),
          ],
        )));
  }
}
