import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formation_maker/dancer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '立ち位置くん'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _dancers = 10;
  late double _deviceWidth, _deviceHeight;
  static const double _stageWidth = 900, _stageHeight= 450;
  late double _drawWidth, _drawHeight;
  late double _boxSize;

  final List<double> _topList =[];
  final List<double> _leftList = [];

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

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    double tmpHeight = _deviceHeight * 0.8;
    double tmpWidth = _deviceWidth * 0.8;

    int xCount = _stageWidth ~/ 90;
    int yCount = _stageHeight ~/ 90;

    if(tmpHeight/yCount <= tmpWidth/xCount){
      _boxSize = tmpHeight/yCount;
    } else {
      _boxSize = tmpWidth/xCount;
    }
    _drawWidth = _boxSize * xCount;
    _drawHeight = _boxSize * yCount;


    for(int i=0; i<_dancers; i++){
      _topList.add(0.0);
      _leftList.add(_boxSize * (i+1));
    }


    List<Positioned> dancerContainerList = createDancers(_dancers, _boxSize*0.7);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: Center(
        child: Stack(children:<Widget>[
          CustomPaint(
            size: Size(_drawWidth, _drawHeight),
            painter: StagePaint(_boxSize, xCount, yCount),
          ),
           for(final container in dancerContainerList)
             container
        ],
      ),
      ),
    );
  }

  List<Positioned> createDancers(int count, double size){
    List<Positioned> dancers = [];

    for(int i=0; i<count; i++){
      Container dancer = createContainer(i, size);

      var container = Positioned(
        top: _topList[i],
        left: _leftList[i],
        child:Draggable(
          feedback: Opacity(
            opacity:0.5,
            child:dancer),
          child: dancer,
          onDragEnd: (dragDetails){
            setState(() {
              _topList[i] = dragDetails.offset.dy;
              _leftList[i] = dragDetails.offset.dx;
            });
          },
        )
      );


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

}

class StagePaint extends CustomPainter {
  late double _boxSize;
  late int _x , _y;
  StagePaint(double boxSize, int x, int y){
    _boxSize = boxSize;
    _x = x;
    _y = y;
  }
  @override
  void paint(Canvas canvas, Size size){
    double width = size.width;
    double height = size.height;

    // 外枠
    var paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    // センターライン
    paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var path = Path();
    double center = width / 2;
    path.moveTo(center, 0);
    path.lineTo(center, height);
    path = dashedPath(path);
    path.close();
    canvas.drawPath(path, paint);

    // 他の線
    paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    // 縦線
    for(int i = 0; i < (_x/2)-1; i++){
      path.moveTo(center+(_boxSize*(i+1)), 0);
      path.lineTo(center+(_boxSize*(i+1)), height);
      path.moveTo(center+(-_boxSize*(i+1)), 0);
      path.lineTo(center+(-_boxSize*(i+1)), height);
    }
    // 横線
    for(int i=0; i<_y-1; i++){
      path.moveTo(0, _boxSize*(i+1));
      path.lineTo(width, _boxSize*(i+1));
    }
    path = dashedPath(path);
    path.close();
    canvas.drawPath(path, paint);

  }

  Path dashedPath(Path source){
    const double step = 7.0;
    const double span = 2.0;
    const double partLength = step + span;
    final PathMetrics pms = source.computeMetrics();
    final Path dash = Path();
    for(var pm in pms){
      final int count = pm.length ~/ partLength;
      for(int i=0; i<count; i++){
        dash.addPath(pm.extractPath(partLength*i, partLength*i+step), Offset.zero);
      }
      final double tail = pm.length % partLength;
      dash.addPath(pm.extractPath(pm.length-tail, pm.length), Offset.zero);
    }
    return dash;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


