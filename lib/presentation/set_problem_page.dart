import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programming_test/domain/set_problem_bloc.dart';

class SetProblem extends StatefulWidget {
  final BuildContext context;
  SetProblem({this.context});

  @override
  _SetProblemState createState() => _SetProblemState();
}

class _SetProblemState extends State<SetProblem> {
  final _bloc = SetProblemBloc();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: StreamBuilder<String>(
                      stream: _bloc.hintStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        }
                        return TextField(
                          controller: _bloc.textController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: snapshot.data,
                          ),
                        );
                      }),
                ),
                StreamBuilder<bool>(
                    stream: _bloc.enableAddBtn,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      return RaisedButton(
                        child: StreamBuilder<String>(
                            stream: _bloc.addStream,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              }
                              return Text(
                                snapshot.data,
                                style: TextStyle(color: Colors.white),
                              );
                            }),
                        disabledColor: Colors.black26,
                        color: Colors.black54,
                        onPressed: snapshot.data
                            ? () => _bloc.add(context: context)
                            : null,
                      );
                    }),
              ],
            ),
            Container(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.white70,
              child: StreamBuilder<List<int>>(
                  stream: _bloc.resultStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data.isEmpty) {
                      return Container();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            snapshot.data[index].toString(),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
