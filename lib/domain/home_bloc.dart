import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _indexStreamController = BehaviorSubject<int>.seeded(0);
  Stream<int> get indexStream => _indexStreamController.stream;

  void updateIndex({int index}) {
    _indexStreamController.sink.add(index);
  }

  void dispose() {
    _indexStreamController.close();
  }
}
