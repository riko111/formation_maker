
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dancerModelProvider = Provider((ref) => DancerModel());

class DancerModel{
  int dancerCount = 0;
  List<double> tops = [];
  List<double> lefts = [];
  List<String> names = [];


}