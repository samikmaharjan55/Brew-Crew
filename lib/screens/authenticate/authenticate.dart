import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn); // !showsignin   =   reverse of what currently is
  }   // void because it does not return a particular value
  
  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleView); // passing parameter first toggleview can be any name
    }else{
      return Register(toggleView: toggleView);
    }
  }
}