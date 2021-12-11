import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
  ));
} 

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      initialData: null,
      value: AuthService().user, // calling instance of authservice class from auth.dart
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Wrapper(),
      ),
    );
  }
}