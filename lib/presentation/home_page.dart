import 'package:flutter/material.dart';
import 'package:programming_test/domain/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming test'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: StreamBuilder<String>(
                        stream: _bloc.hintStream,
                        builder: (context, snapshot) {
                          return TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: snapshot.data,
                            ),
                          );
                        }),
                  ),
                  StreamBuilder<bool>(
                      stream: _bloc.enableAddBtn,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          child: StreamBuilder<String>(
                              stream: _bloc.addStream,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data,
                                  style: TextStyle(color: Colors.white),
                                );
                              }),
                          disabledColor: Colors.black26,
                          color: Colors.black54,
                          onPressed: snapshot.data
                              ? () => _bloc.add(controller: _controller)
                              : null,
                        );
                      }),
                ],
              ),
              Container(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                child: StreamBuilder<List<int>>(
                    stream: _bloc.resultStream,
                    builder: (context, snapshot) {
                      if (snapshot.data.isEmpty) {
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
