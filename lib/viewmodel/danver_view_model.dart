import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/repository/dancer_repository.dart';

final dancerViewModelProvider = ChangeNotifierProvider((ref) => DancerViewModel(repository: ref.read(dancerRepositoryProvider)));

class DancerViewModel extends ChangeNotifier {
  int _dancerCount = 0;
  final List<double> _tops = [];
  final List<double> _lefts = [];
  final List<String> _names = [];

  DancerRepository? repository;

  DancerViewModel({this.repository});

  void initialize(int count, double size) {
    _dancerCount = count;
    for(int i=0; i<dancerCount; i++){
      _tops.add(0.0);
      _lefts.add(size * (i+1));
    }
    repository?.initialize(count,size);
  }

  List<String> get names => _names;

  List<double> get lefts => _lefts;

  List<double> get tops => _tops;

  int get dancerCount => _dancerCount;

  void changePoint(int count, double top, double left) {
    repository?.changePoint(count, top, left).then((value) {
      _tops[count] = value.tops[count];
      _lefts[count] = value.lefts[count];
      notifyListeners();
    });
  }
}