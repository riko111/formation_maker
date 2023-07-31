
import 'package:flutter/cupertino.dart';
import 'package:formation_maker/const/colors.dart';
import 'package:formation_maker/ui/widget/stage/stage_y_axis.dart';

class StageFloor extends StatelessWidget {
  const StageFloor({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _FloorPainter(width:width, height: height),
      ),
    );
  }
}

class _FloorPainter extends CustomPainter{
  _FloorPainter({required this.width, required this.height});
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    // 舞台の中心点
    List<double> centerPoint = [size.width /2, size.height/2];

    Rect rect = Rect.fromCenter(
        center: Offset(centerPoint[0], centerPoint[1]),
        width: width,
        height: height
    );

    final paint = Paint()..strokeWidth = 1;
    canvas.drawRect(rect, paint..color=const Color.fromARGB(200, 214, 198, 175));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}