import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StageXAxis extends StatelessWidget {
  const StageXAxis({super.key, required this.xCount, required this.yCount, required this.boxSize, required this.height});
  static const scaleTextHeight = 40.0;
  final int xCount;
  final int yCount;
  final double boxSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _XAxisPainter(xCount: xCount, yCount: yCount, boxSize: boxSize, height: height),
      ),
    );
  }

}

class _XAxisPainter extends CustomPainter {
  const _XAxisPainter({required this.xCount, required this.yCount , required this.boxSize, required this.height});
  static const _scaleTextLeftMargin = 2.0;
  final int xCount;
  final int yCount;
  final double boxSize;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    // 舞台の中心x座標
    List<double> centerPoint = [size.width /2, size.height/2];
    // 舞台上y座標
    double top = centerPoint[1] - height/2;

    TextPainter makeTextPainter(int i) {
      return TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 12),
          text: i.toString(),
        ),
      )..layout();
    }

    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;

    final textY = top + height + 12;
    final no = xCount~/2;

    //センターライン
    canvas.drawVerticalDottedLine(
      paint: paint,
      x: centerPoint[0],
      y: top,
      maxY: top + height,
    );
    makeTextPainter(0).paint(
      canvas,
      Offset(centerPoint[0] - _scaleTextLeftMargin, textY),
    );

    // 上下ライン
    for(int i=1; i<no; i++){
      canvas.drawVerticalDottedLine(
        paint: paint,
        x: centerPoint[0]+(boxSize*i),
        y: top,
        maxY: top + height,
      );

      makeTextPainter(i).paint(
        canvas,
        Offset(centerPoint[0]+(boxSize*i) - _scaleTextLeftMargin, textY),
      );

      canvas.drawVerticalDottedLine(
        paint: paint,
        x: centerPoint[0]-(boxSize*i),
        y: top,
        maxY: top + height,
      );
      makeTextPainter(i).paint(
        canvas,
        Offset(centerPoint[0]-(boxSize*i) - _scaleTextLeftMargin, textY),
      );
    }



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


extension on Canvas {
  static const _dotHeight = 2.0;
  static const _dotSpace = 2.0;

  /// {x, y} から {x, maxY} までドットボーダーラインを描画
  void drawVerticalDottedLine({
    required Paint paint,
    required double x,
    required double y,
    required double maxY,
  }) {
    while (y < maxY) {
      drawLine(Offset(x, y), Offset(x, y + _dotHeight), paint);
      y += _dotHeight + _dotSpace;
    }
  }
}
