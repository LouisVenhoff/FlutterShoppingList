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
  
  GraphQLConnector connector = GraphQLConnector();

  @override
  void initState() {
    super.initState();

    updateList();
    connector.applyNewItemSubscription((int id, String description) => updateList());
    connector.applyItemChangedSubscription(changeItemState);
  }

  void addNewItem(String name) async {
    
    bool itemAdded = await connector.addItem(ListItem(name, 3,false));

    if(!itemAdded){
      print("There was an error while adding item to db");
    }
    
  }

  void updateList()async {
     
   
      List<ListItem> fetchedItems = await connector.allItems();

      setState(() {
        items = fetchedItems;
      });

  }

  void addItemToList(int id, String description) async {
    setState(() {
      items.add(ListItem(description, id, false));
    });
  }

  void changeItemState(int id, bool status){
    for(int i = 0; i < items.length; i++){
      if(items[i].id == id){
        setState(() => items[i].isChecked = status);
      }
    }
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
