import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/number_model.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';

import '../const/colors.dart';
import '../viewmodel/danver_view_model.dart';
// ignore: must_be_immutable
class NumberPage extends ConsumerWidget {
  const NumberPage(this.fileViewModel, this.filePath, {super.key});

  final FileViewModel fileViewModel;
  final File? filePath;

  Future<NumberModel> initializer() async {
    NumberModel numberModel = NumberModel();
    if (filePath == null) {
      fileViewModel.getFile();
    }
    await numberModel.load(filePath!);
    return numberModel;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     double deviceWidth = MediaQuery.of(context).size.width;
     double deviceHeight = MediaQuery.of(context).size.height;
     final viewModel = ref.watch(dancerViewModelProvider);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    return FutureBuilder(
        future: initializer(),
        builder:(context, snapshot){
          if(snapshot.data != null) {
            NumberModel numberModel = snapshot.data!;
            viewModel.initializeList(numberModel,0);
            return drawView(numberModel, viewModel, deviceHeight, deviceWidth, ref);
          } else {
            return const Text('');
          }
        },
    );

  }

  WillPopScope drawView(NumberModel numberModel, DancerViewModel dancerViewModel, double deviceHeight, double deviceWidth, WidgetRef ref) {
    //var numberModel = snapshot.data!;
    // 描画範囲
    double drawHeight = deviceHeight * 0.8;
    double drawWidth = deviceWidth * 0.8;

    // 描画する舞台のサイズ
    double stageHeight = drawHeight * 0.9;
    double stageWidth = drawWidth * 0.9;

    int xCount = numberModel.stageWidth ~/ 90;
    int yCount = numberModel.stageHeight ~/ 90;

    double boxSize;

    if(stageHeight/yCount <= stageWidth/xCount){
      boxSize = stageHeight/yCount;
    } else {
      boxSize = stageWidth/xCount;
    }

    // //viewModel.initialize(numberModel.dancerCount, boxSize);
    // dancerViewModel.initializeList(numberModel,0);
    List<Positioned> dancerContainerList = createDancers(numberModel.dancerCount, boxSize*0.7, dancerViewModel);

    return WillPopScope(
        onWillPop: () async{ return false;},
        child:
        Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Stack(children:<Widget>[
                  CustomPaint(
                    size: Size(drawWidth, drawHeight),
                    painter: StagePaint(boxSize, xCount, yCount, stageWidth, stageHeight),
                  ),
                  for(final container in dancerContainerList)
                    container,
                  ],
                ),
                TextButton(
                  onPressed: ()=>{
                    dancerViewModel.setList(numberModel,0),
                    fileViewModel.updateFile(numberModel),
                  },
                  child:const Text('save')
                ),
              ]
            ),
          ),
        )
    );
  }

  List<Positioned> createDancers(int count, double size, DancerViewModel viewModel){
    List<Positioned> dancers = [];
    List<double> leftList = viewModel.lefts;
    List<double> topList = viewModel.tops;

    for(int i=0; i<count; i++){
      Container dancer = createDancerContainer(i, size, viewModel.names);

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

  Container createDancerContainer(int i, double size, List<String> names){
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
          names[i],
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
  late double _stageWidth, _stageHeight;
  StagePaint(double boxSize, int x, int y, double stageWidth, double stageHeight){
    _boxSize = boxSize;
    _x = x;
    _y = y;
    _stageWidth = stageWidth;
    _stageHeight = stageHeight;
  }
  @override
  void paint(Canvas canvas, Size size){
    double width = size.width;
    double height = size.height;

    double left = (width - _stageWidth) / 2;
    double top = 0;

    // 外枠
    var paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(left, top, _stageWidth, _stageHeight), paint);

    // センターライン
    paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var path = Path();
    double center = _stageWidth / 2 + left;
    path.moveTo(center, top);
    path.lineTo(center, _stageHeight+top);
    path = dashedPath(path);
    path.close();
    canvas.drawPath(path, paint);

    // 他の線
    paint = Paint()..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    // 縦線
    for(int i = 0; i < (_x/2)-1; i++){
      path.moveTo(center+(_boxSize*(i+1)), top);
      path.lineTo(center+(_boxSize*(i+1)), _stageHeight+top);
      path.moveTo(center+(-_boxSize*(i+1)), top);
      path.lineTo(center+(-_boxSize*(i+1)), _stageHeight+top);
    }
    // 横線
    for(int i=0; i<_y-1; i++){
      path.moveTo(left, _boxSize*(i+1)+top);
      path.lineTo(_stageWidth+left, _boxSize*(i+1)+top);
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

