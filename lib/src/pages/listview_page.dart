import 'dart:async';

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ScrollController _scrollController = new ScrollController();

  List<int> _numList = new List();
  int _lastItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _add10();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lists Page'),
      ),
      body: Stack(
        children: <Widget>[
          _createLoading(),
          _createList(),
        ],
      ),
    );
  }

  Widget _createList() {
    return RefreshIndicator(
      onRefresh: getFirstPage,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _numList.length,
        itemBuilder: (BuildContext context, int index) {
          final image = _numList[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/500/300?image=$image'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
      ),
    );
  }

  void _add10() {
    for (var i = 0; i < 10; i++) {
      _lastItem++;
      _numList.add(_lastItem);
    }
    setState(() {});
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);

    new Timer(duration, httpResp);
  }

  void httpResp() {
    _isLoading = false;

    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250),
    );

    _add10();
  }

  Widget _createLoading() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Future<Null> getFirstPage() async {
    final duration = Duration(seconds: 2);
    new Timer(duration, () {
      _numList.clear();
      _lastItem++;
      _add10();
    });

    return Future.delayed(duration);
  }
}
