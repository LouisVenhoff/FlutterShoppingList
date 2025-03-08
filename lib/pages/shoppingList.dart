import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shopping_list/classes/graphQLConnector.dart';
import 'package:shopping_list/classes/listItem.dart';
import 'package:shopping_list/components/itemInput.dart';
import 'package:shopping_list/components/postItList.dart';


class ShoppingList extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  
  List<ListItem> items = [];
  

  void addNewItem(String name) async {
    //setState(() => items.add(ListItem(name, 1, false)));
    GraphQLConnector connector = GraphQLConnector();
   
    List<ListItem> fetchedItems = await connector.allItems();
    

    setState(() {
      items = fetchedItems;
    });
  }

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
            SizedBox(width: 400, height: 700,child: PostItList(items)),
            ItemInput((String val) => addNewItem(val)),
          ],
        )));
  }
}
