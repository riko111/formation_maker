import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:formation_maker/main.dart';

class Dancer extends State<MyHomePage>{
  double _top = 0;
  double _left = 0;

  List<Color> colors =[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.purpleAccent,
    Colors.pink,
  ];

  List<Container> createDancers(int count, double size){
    List<Container> dancers = [];

    for(int i=0; i<count; i++){
      _left = size * (i+1);
      Container dancer = createContainer(i, size);

      var container = Container(
        child: GestureDetector(
          onPanDown: (details) => print('onPanDown'),
          onPanUpdate: (dragUpdateDetails){
            Offset position = dragUpdateDetails.localPosition;
            setState(() {
              _top = position.dy;
              _left = position.dx;
            });
          },
          child: Positioned(
            left:_left,
            top:_top,
            child: dancer,
          ),
        ),

      );



/*
      var container = Positioned(
        top: _top,
        left: _left,
        child:Draggable(
          feedback: Opacity(
            opacity:0.5,
            child:dancer),
          child: dancer,
          onDragEnd: (dragDetails){
            setState(() {
              _top = dragDetails.offset.dy;
              _left = dragDetails.offset.dx;
            });
          },
        )
      );
*/
      dancers.add(container);
    }
    return dancers;
  }

  Container createContainer(int i, double size){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colors[i],width: 2),
      ),
      height: size,
      width: size,
      child: Container(
        alignment: Alignment.center,
        width: size,
        child: Text(
          (i+1).toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: colors[i],fontSize: size*0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
