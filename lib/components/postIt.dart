import 'package:flutter/material.dart';
import 'dart:math';

class PostIt extends StatefulWidget {
  String name;
  bool isChecked;

  PostIt(this.name, this.isChecked, {super.key});

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
  
  void toggleChecked(){
    setState((){
      isChecked = !isChecked;
    });
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
