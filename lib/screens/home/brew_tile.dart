import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[brew.strength],
            radius: 25.0,
          ),
          title: Text(
            brew.name
          ),
          subtitle: Text(
            'Takes ${brew.sugars} sugars'
          ),
        ),
      ),
    );
  }
}
