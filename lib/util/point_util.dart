
import 'dart:ui';

class PointUtil {
  /*static Offset convertOffsetFromPoint(double x , double y , double boxSize, Offset centerPoint) {
    return Offset(centerPoint.dx + x*boxSize, centerPoint.dy + y*boxSize);
  }

  static List<double> convertPointFromOffset(Offset offset , double boxSize, Offset centerPoint){
    double x = (offset.dx - centerPoint.dx )/boxSize;
    double y = (offset.dy - centerPoint.dy)/boxSize;
    return [x,y];
  }*/

  static Offset convertOffsetFromPoint(double x , double y , double cm) {
    return Offset(x/cm, y/cm);
  }

  static List<double> convertPointFromOffset(Offset offset ,double cm){
    double x = offset.dx * cm;
    double y = offset.dy * cm;
    return [x,y];
  }

}