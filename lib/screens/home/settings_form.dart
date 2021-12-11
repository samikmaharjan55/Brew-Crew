import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  Slider(
                    value: (_currentStrength).toDouble(),
                    activeColor: Colors.brown[_currentStrength],
                    inactiveColor: Colors.brown[_currentStrength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),

                  // slider
                  ElevatedButton(
                    child: Text(
                      'Update',
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars,
                          _currentName,
                          _currentStrength,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
