import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programming_test/domain/bin_operation.dart';
import 'package:rxdart/rxdart.dart';

class BinaryProblemBloc {
  TextEditingController firstNumController = TextEditingController();
  TextEditingController secondNumController = TextEditingController();
  List<String> operations = ['+', '-', '*', '/', '%'];
  String currentOperator;

  final _currentOperationController =
      BehaviorSubject<String>.seeded('Operação');
  Stream<String> get currentOperationStream =>
      _currentOperationController.stream;

  final _resultStreamController = BehaviorSubject<String>();
  Stream<String> get resultStream => _resultStreamController.stream;

  void setCurrentOperation({@required String value}) {
    currentOperator = value;
    _currentOperationController.sink.add(value);
  }

  void evaluate({BuildContext context}) {
    if (!valid()) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Preencha os campos corretamente'),
        ),
      );
      return;
    }
    switch (currentOperator) {
      case '+':
        _resultStreamController.sink.add(BinOperation.sum(
            firstNumber: firstNumController.text,
            secondNumber: secondNumController.text));
        break;
      case '-':
        _resultStreamController.sink.add(BinOperation.subtraction(
            firstNumber: firstNumController.text,
            secondNumber: secondNumController.text));
        break;
      case '*':
        _resultStreamController.sink.add(BinOperation.product(
            firstNumber: firstNumController.text,
            secondNumber: secondNumController.text));
        break;
      case '/':
        _resultStreamController.sink.add(BinOperation.division(
            firstNumber: firstNumController.text,
            secondNumber: secondNumController.text));
        break;
      case '%':
        _resultStreamController.sink.add(BinOperation.mod(
            firstNumber: firstNumController.text,
            secondNumber: secondNumController.text));
        break;
    }
  }

  bool valid() {
    final nonBinaryExp = RegExp("[2-9]");
    if (firstNumController.text == null ||
        secondNumController.text == null ||
        currentOperator == null ||
        firstNumController.text.length < 8 ||
        secondNumController.text.length < 8 ||
        currentOperator.length < 1 ||
        currentOperator.length > 1 ||
        nonBinaryExp.hasMatch(firstNumController.text) ||
        nonBinaryExp.hasMatch(secondNumController.text)) {
      return false;
    }
    try {
      int.parse(firstNumController.text, radix: 2);
      int.parse(secondNumController.text, radix: 2);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void dispose() {
    _resultStreamController.close();
    _currentOperationController.close();
  }
}
