import 'package:flutter/material.dart';
import 'package:shopping_list/classes/listItem.dart';
import 'package:shopping_list/components/postIt.dart';

class PostItList extends StatefulWidget {
  List<ListItem> items;

  PostItList(this.items);

  @override
  State<StatefulWidget> createState() => _PostItListState();
}

class _PostItListState extends State<PostItList> {
  
  List<ListItem> items = [];
  
  @override
  void didUpdateWidget(covariant PostItList oldWidget){
    super.didUpdateWidget(oldWidget);
    
    setState(() {
      items = widget.items;
    });

  }

  List<PostIt> generatePostIts(){
    return items.map((ListItem item) => PostIt(item.id, item.name, item.isChecked)).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    // return GridView.count(crossAxisCount: 3, children: generatePostIts());
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: items.length,
    reverse: true,
    itemBuilder:(context, index) {
      return PostIt(items[index].id, items[index].name, items[index].isChecked);
    });
  }
}
