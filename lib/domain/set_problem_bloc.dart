import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SetProblemBloc {
  bool firstInsertion = true;
  int quantity;
  List<int> numbers = [];
  TextEditingController textController = TextEditingController();

  final _hintStreamController = BehaviorSubject<String>.seeded(firstHintText);
  Stream<String> get hintStream => _hintStreamController.stream;

  final _addStreamController = BehaviorSubject<String>.seeded(firstAddButton);
  Stream<String> get addStream => _addStreamController.stream;

  final _enableAddStreamController = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get enableAddBtn => _enableAddStreamController.stream;

  final _resultStreamController = BehaviorSubject<List<int>>.seeded([]);
  Stream<List<int>> get resultStream => _resultStreamController.stream;

  static String firstHintText = 'Digite a quantidade';
  static String laterHintText = 'Digite um número';

  static String firstAddButton = 'Definir';
  static String laterAddButton = 'Adicionar';

  void add({BuildContext context}) {
    showMessage() => Scaffold.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Insira um número válido'),
          ),
        );
    cancelInsertion() {
      showMessage();
      textController.clear();
    }

    int insertedValue;
    try {
      insertedValue = int.parse(textController.text);
      if (firstInsertion) {
        if (insertedValue < 1 || insertedValue > 1000) {
          cancelInsertion();
          return;
        }
      } else {
        if (insertedValue < -1000 || insertedValue > 1000) {
          cancelInsertion();
          return;
        }
      }
    } catch (e) {
      cancelInsertion();
      return;
    }
    if (firstInsertion) {
      quantity = insertedValue;
      init();
    } else {
      numbers.add(insertedValue);
    }
    if (quantity == numbers.length) {
      _enableAddStreamController.sink.add(false);
      evaluate();
    }
    textController.clear();
  }

  void evaluate() {
    numbers = numbers.toSet().toList();
    numbers.sort();
    _resultStreamController.sink.add(numbers);
    reset();
  }

  void init() {
    numbers = [];
    firstInsertion = false;
    _hintStreamController.sink.add(laterHintText);
    _addStreamController.sink.add(laterAddButton);
    _resultStreamController.sink.add([]);
  }

  void reset() {
    firstInsertion = true;
    _hintStreamController.sink.add(firstHintText);
    _addStreamController.sink.add(firstAddButton);
    _enableAddStreamController.sink.add(true);
  }

  void dispose() {
    _hintStreamController.close();
    _addStreamController.close();
    _enableAddStreamController.close();
    _resultStreamController.close();
  }
}
