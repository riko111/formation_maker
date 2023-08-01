
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/const/colors.dart';
import 'package:formation_maker/model/dancer_model.dart';

final dancerRepositoryProvider = Provider((ref) => DancerRepositoryImpl(model: ref.read(dancerModelProvider)));

abstract class DancerRepository {
  Future<List<DancerModel>> changePoint(int count, double top, double left);

  void initialize(int count, double size);
  void initializeList(List<double> tops, List<double> lefts, List<String> names);
  Future<List<DancerModel>> addDancer(double x, double y);
  Future<List<DancerModel>> getDancerList();
}

class DancerRepositoryImpl implements DancerRepository {
  DancerRepositoryImpl({required List<DancerModel> model}) :_model = model;
  
  //final DancerModel _model;
  final List<DancerModel> _model;

  @override
  Future<List<DancerModel>> changePoint(int count, double top, double left) {
    _model[count].point = [left , top];
    return Future.value(_model);
  }

  @override
  void initialize(int count, double size) {
    for(int i=0; i<count; i++){
      _model.add(DancerModel()..point=[0,0]..name=(i+1).toString()..num=i);
    }
  }

  @override
  void initializeList(List<double> tops, List<double> lefts, List<String> names) {
    for(int i=0; i<names.length; i++){
      _model.add(DancerModel()..point=[lefts[i],tops[i]]..name=names[i]..num=i);
    }

  }

  @override
  Future<List<DancerModel>> addDancer(double x, double y) {
    int num = _model.length;
    _model.add(
        DancerModel()
          ..point=[x,y]..name=(num+1).toString()..num=num..color=DancerColors.colors[num].value
    );
    return Future.value(_model);
  }

  @override
  Future<List<DancerModel>> getDancerList() {
    return Future.value(_model);
  }

}