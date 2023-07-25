
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/dancer_model.dart';

final dancerRepositoryProvider = Provider((ref) => DancerRepositoryImpl(model: ref.read(dancerModelProvider)));

abstract class DancerRepository {
  Future<DancerModel> changePoint(int count, double top, double left);

  void initialize(int count, double size);
}

class DancerRepositoryImpl implements DancerRepository {
  DancerRepositoryImpl({required DancerModel model}) :_model = model;
  
  final DancerModel _model;

  @override
  Future<DancerModel> changePoint(int count, double top, double left) {
    _model.tops[count] = top;
    _model.lefts[count] = left;
    return Future.value(_model);
  }

  @override
  void initialize(int count, double size) {
    _model.dancerCount = count;
    for(int i=0; i<count; i++){
      _model.tops.add(0.0);
      _model.lefts.add(size * (i+1));
    }
  }

}