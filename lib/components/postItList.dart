import 'package:flutter/material.dart';
import 'package:shopping_list/components/postIt.dart';

class PostItList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PostItListState();

}

class _PostItListState extends State<PostItList>{
  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 3, children: [
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Waschmitteldose"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
      PostIt("Test"),
    ]);
  }
  
}