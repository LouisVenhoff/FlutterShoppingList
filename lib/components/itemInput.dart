import 'package:flutter/material.dart';

class ItemInput extends StatefulWidget {
  
  Function(String value) callback;

  ItemInput(this.callback, {super.key});
  
  @override
  State<StatefulWidget> createState() => _ItemInputState();
}

class _ItemInputState extends State<ItemInput> {
  InputDecoration textFieldDecorator = const InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(18, 140, 126, 1), width: 0.0)),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(37, 211, 102, 1), width: 1.0)),
  );

  TextEditingController textController = new TextEditingController();

  
  void addItem(){
    widget.callback(textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: 300,
              height: 100,
              child: TextField(decoration: textFieldDecorator, controller: textController)),
          FloatingActionButton(
              onPressed: addItem,
              backgroundColor: Color.fromRGBO(37, 211, 102, 1),
              child: Icon(Icons.send, color: Color.fromRGBO(7, 94, 84, 1)))
        ]);
  }
}
