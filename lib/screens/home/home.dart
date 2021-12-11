import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {


  final AuthService _auth = AuthService(); // instance of class authservice from auth.dart


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });  //built in function
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon:Icon(Icons.person),
             label: Text('Logout'),
             onPressed: () async{
             await _auth.signOut();
             },
             style: TextButton.styleFrom(
               primary: Colors.black,
             ),
             ),
             TextButton.icon(
               onPressed: ()=> _showSettingsPanel(),
              icon: Icon(Icons.settings),
               label: Text('Settings'),
               style: TextButton.styleFrom(
               primary: Colors.black,
             ),
               ),
        ],
        ),
        body: BrewList(),
      ),
    );
  }
}