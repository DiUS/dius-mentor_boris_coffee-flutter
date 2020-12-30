import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Response.dart';
import 'MenuProvider.dart';

class BaseMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuUseCases(),
        child: Center(
          child: Consumer<MenuUseCases>(
            builder: (context, model, child) => Column(
              children: <Widget>[Text("Menu")] + menuListFrom(model.list),
            ),
          ),
        ));
  }
}

List<Widget> menuListFrom(Response<List<String>> r) {
  if (r is Success) {
    final List<String> list = (r as Success).body;
    return list
        .map((it) => MaterialButton(
              child: Text(it),
              onPressed: () {},
              color: Colors.white,
            ))
        .toList();
  } else {
    return [Text("Oh no!")];
  }
}
