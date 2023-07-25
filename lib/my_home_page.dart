import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/number_model.dart';
import 'package:formation_maker/const/colors.dart';
import 'package:formation_maker/viewmodel/danver_view_model.dart';

class MyHomePage extends ConsumerWidget {
  late final NumberModel model;
  final int _dancers = 10;
  final String title = '立ち位置くん';
  final String numberName = 'testNumber';
  final String serialNumber = 'test';
  static const int _stageWidth = 900, _stageHeight= 450;

  MyHomePage({Key? key,  title}) : super(key: key){
    model = NumberModel();
    model.serialNumber = serialNumber;
    model.numberName = title;
    model.sceneCount = _dancers;
    model.sceneCount = 1;
    model.stageWidth = _stageWidth;
    model.stageHeight = _stageHeight;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final _ioRepository = ref.watch(ioProvider);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double tmpHeight = deviceHeight * 0.8;
    double tmpWidth = deviceWidth * 0.8;

    int xCount = _stageWidth ~/ 90;
    int yCount = _stageHeight ~/ 90;

    double boxSize;

    if(tmpHeight/yCount <= tmpWidth/xCount){
      boxSize = tmpHeight/yCount;
    } else {
      boxSize = tmpWidth/xCount;
    }
    double drawWidth = boxSize * xCount;
    double drawHeight = boxSize * yCount;

    final viewModel = ref.watch(dancerViewModelProvider);
    viewModel.initialize(_dancers, boxSize);
    List<Positioned> dancerContainerList = createDancers(_dancers, boxSize*0.7, viewModel);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: Center(
        child: Stack(children:<Widget>[
          CustomPaint(
            size: Size(drawWidth, drawHeight),
            painter: StagePaint(boxSize, xCount, yCount),
          ),
          for(final container in dancerContainerList)
            container
        ],
        ),
      ),
    );
  }

  List<Positioned> createDancers(int count, double size, DancerViewModel viewModel){
    List<Positioned> dancers = [];
    List<double> leftList = viewModel.lefts;
    List<double> topList = viewModel.tops;

    for(int i=0; i<count; i++){
      Container dancer = createContainer(i, size);

      var container = Positioned(
        top: topList[i],
        left: leftList[i],
        child:Draggable(
          feedback: Opacity(
              opacity:0.5,
              child:dancer),
          child: dancer,
          onDragEnd: (dragDetails){
            viewModel.changePoint(i, dragDetails.offset.dy, dragDetails.offset.dx);
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
        border: Border.all(color: DancerColors.colors[i],width: 2),
      ),
      height: size,
      width: size,
      child: Container(
        alignment: Alignment.center,
        width: size,
        child: Text(
          (i+1).toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: DancerColors.colors[i],fontSize: size*0.5),
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
