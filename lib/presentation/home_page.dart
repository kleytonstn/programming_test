import 'package:flutter/material.dart';
import 'package:programming_test/domain/home_bloc.dart';
import 'package:programming_test/presentation/binary_problem_page.dart';
import 'package:programming_test/presentation/set_problem_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      SetProblem(context: context),
      BinaryProblem(context: context),
    ];
    return StreamBuilder<int>(
      stream: _bloc.indexStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Programming test')),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: snapshot.data,
            onTap: (index) => _bloc.updateIndex(index: index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                title: Text('Set problem'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                title: Text('Binary problem'),
              ),
            ],
          ),
          body: SafeArea(
            top: true,
            bottom: true,
            child: pages[snapshot.data],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
