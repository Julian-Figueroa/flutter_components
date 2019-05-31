import 'package:flutter/material.dart';
import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icon_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listItems(context, snapshot.data),
        );
      },
    );
  }

  List<Widget> _listItems(BuildContext context, List<dynamic> data) {
    final List<Widget> options = [];

    data.forEach((opt) {
      final tempWidget = ListTile(
        title: Text(opt['text']),
        leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
        ),
        onTap: () {
          Navigator.pushNamed(context, opt['route']);
          // final route = MaterialPageRoute(
          //   builder: (context) => AlertPage(),
          // );

          // Navigator.push(context, route);
        },
      );

      options..add(tempWidget)..add(Divider());
    });

    return options;
  }
}
