
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dancerModelProvider = Provider((ref) => DancerModel());

class DancerModel{
  int dancerCount = 0;
  final List<double> tops = [];
  final List<double> lefts = [];
  final List<String> names = [];


}