import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shopping_list/classes/graphQLConnector.dart';

class PostIt extends StatefulWidget {
  int id;
  String name;
  bool isChecked;

  PostIt(this.id, this.name, this.isChecked, {super.key});

  @override
  State<StatefulWidget> createState() => _PostItState();
}

class _PostItState extends State<PostIt> {
  
  bool isChecked = false;
  
  @override
  void initState(){
    super.initState();

    isChecked = widget.isChecked;
  }
  
  @override
  void didUpdateWidget(covariant PostIt oldWidget){
    super.didUpdateWidget(oldWidget);

    setState(() {
      isChecked = widget.isChecked;
    });
  }
  
  void toggleChecked() async {
    
    GraphQLConnector connector  = GraphQLConnector();
    
    setState((){
      isChecked = !isChecked;
    });

    connector.toggleItem(widget.id, isChecked);

  }


  int generateRandomTilt() {
    Random random = Random();

    bool isNegative = random.nextBool();

    return isNegative ? -4 : 4;
  }

  Color backgroundColor(){
    return isChecked ?  Color.fromRGBO(236,229,221, 1) : Color.fromRGBO(220, 248, 198, 1);
  }

  TextStyle nameTextStyle(){
    return TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null, color: Colors.black);
  }

  void updateCheckedState(bool state){
    
    setState(() {
      isChecked = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: generateRandomTilt() * (pi / 180),
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: toggleChecked,
            child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(20),
          width: 120,
          height: 120,
          color: backgroundColor(),
          child: Center(
            child: Text(widget.name, style: nameTextStyle())
          ),
        )));
  }
}
