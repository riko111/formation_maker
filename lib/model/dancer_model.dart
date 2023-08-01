

import 'package:flutter_riverpod/flutter_riverpod.dart';

final dancerModelProvider = Provider((ref) => <DancerModel>[]);

class DancerModel{
  late int num;
  late String name;
  late int color;
  List<double> point = [];

  DancerModel();
}