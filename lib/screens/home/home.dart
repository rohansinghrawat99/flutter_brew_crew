import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/models/brew.dart';
import 'package:ninja_brew_crew/screens/home/brew_list.dart';
import 'package:ninja_brew_crew/screens/home/setting_form.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:provider/provider.dart';



class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsFrom(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut();
            }, icon: Icon(Icons.person), label: Text("Logout")),
            FlatButton.icon(onPressed: () {
              _showSettingsPanel();
            }, icon: Icon(Icons.settings), label: Text("Settings"))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
