import 'package:flutter/material.dart';
import 'package:programming_test/domain/binary_problem_bloc.dart';

class BinaryProblem extends StatefulWidget {
  final BuildContext context;
  BinaryProblem({this.context});

  @override
  _BinaryProblemState createState() => _BinaryProblemState();
}

class _BinaryProblemState extends State<BinaryProblem> {
  final _bloc = BinaryProblemBloc();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _bloc.firstNumController,
            keyboardType: TextInputType.number,
            maxLength: 8,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Primeiro número',
            ),
          ),
          StreamBuilder<String>(
              stream: _bloc.currentOperationStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return DropdownButton<String>(
                  items: _bloc.operations.map((String operation) {
                    return DropdownMenuItem<String>(
                        value: operation, child: Text(operation));
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    _bloc.setCurrentOperation(value: value);
                  },
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  hint: Text(snapshot.data),
                );
              }),
          TextField(
            controller: _bloc.secondNumController,
            keyboardType: TextInputType.number,
            maxLength: 8,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Segundo número',
            ),
          ),
          RaisedButton(
            child: Text(
              'Calcular',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black54,
            disabledColor: Colors.black26,
            onPressed: () => _bloc.evaluate(context: context),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: StreamBuilder<String>(
                    stream: _bloc.resultStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      return Text(snapshot.data);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
