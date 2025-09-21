import 'package:flutter/material.dart';

class StageYAxis extends StatelessWidget {
  const StageYAxis({super.key, required this.scaleCount, required this.boxSize,required this.width, required this.height});
  final int scaleCount;
  final double boxSize;
  final double width;
  final double height;
  //static const scaleTextWidth = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _YAxisPainter(yCount: scaleCount,boxSize: boxSize, width: width, height: height),
      ),
    );
  }

}

class _YAxisPainter extends CustomPainter {
  const _YAxisPainter({required this.yCount, required this.boxSize,required this.width, required this.height});
  final int yCount;
  final double boxSize;
  final double width;
  final double height;


  @override
  void paint(Canvas canvas, Size size) {
    // 舞台の中心点
    List<double> centerPoint = [size.width /2, size.height/2];
    // 舞台上y座標
    double top = centerPoint[1] - height/2;
    // 舞台左x座標
    double left = centerPoint[0] - width/2;


    final paint = Paint()
    ..color = Colors.black12
    ..strokeWidth = 2;

    final yAxisScaleMarginTop = height / yCount;


    for (var i = 0; i <= yCount; i++) {
      // ボーダー
      final y = yAxisScaleMarginTop * i;
      canvas.drawLine(Offset(left, y+top), Offset(left+width, y+top), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}