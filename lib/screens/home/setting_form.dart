import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/models/user_data.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:ninja_brew_crew/shared/constants.dart';
import 'package:ninja_brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsFrom extends StatefulWidget {
  @override
  _SettingsFromState createState() => _SettingsFromState();
}

class _SettingsFromState extends State<SettingsFrom> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            print(userData.sugar);
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your Brew Settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter a Name' : null,
                      onChanged: (val) => setState(() => _currentName = val)),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugar ?? userData.sugar,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text("$sugar Sugars"));
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val)
                  ),
                  Slider(
                    value:
                        (_currentStrength ?? userData.strength).roundToDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData.sugar,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
