import 'package:flutter/material.dart';

class BinOperation {
  static String sum(
      {@required String firstNumber, @required String secondNumber}) {
    int resultNumber;
    resultNumber = int.tryParse(
            ((int.parse(firstNumber, radix: 2)).toRadixString(10))) +
        int.tryParse(((int.parse(secondNumber, radix: 2)).toRadixString(10)));
    return (resultNumber).toRadixString(2);
  }

  static String subtraction(
      {@required String firstNumber, @required String secondNumber}) {
    int resultNumber;
    resultNumber = int.tryParse(
            ((int.parse(firstNumber, radix: 2)).toRadixString(10))) -
        int.tryParse(((int.parse(secondNumber, radix: 2)).toRadixString(10)));
    return (resultNumber).toRadixString(2);
  }

  static String product(
      {@required String firstNumber, @required String secondNumber}) {
    int resultNumber;
    resultNumber = (int.tryParse(
            ((int.parse(firstNumber, radix: 2)).toRadixString(10)))) *
        (int.tryParse(((int.parse(secondNumber, radix: 2)).toRadixString(10))));
    return (resultNumber).toRadixString(2);
  }

  static String division(
      {@required String firstNumber, @required String secondNumber}) {
    int resultNumber;
    if ((int.tryParse(
            ((int.parse(secondNumber, radix: 2)).toRadixString(10)))) !=
        0) {
      resultNumber = (int.tryParse(
              ((int.parse(firstNumber, radix: 2)).toRadixString(10)))) ~/
          (int.tryParse(
              ((int.parse(secondNumber, radix: 2)).toRadixString(10))));
      return (resultNumber).toRadixString(2);
    }
    // TODO: Check division by zero
  }

  static String mod(
      {@required String firstNumber, @required String secondNumber}) {
    int resultNumber;
    resultNumber = (int.tryParse(
            ((int.parse(firstNumber, radix: 2)).toRadixString(10)))) %
        (int.tryParse(((int.parse(secondNumber, radix: 2)).toRadixString(10))));
    return (resultNumber).toRadixString(2);
  }
}
