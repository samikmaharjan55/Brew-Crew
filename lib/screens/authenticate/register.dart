import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;   // constructor of parameter from authenticate
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>(); // key formstate
  bool loading = false;


  String email = '';
  String password = '';
  String error = '';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
      backgroundColor: Colors.brown[400],
      elevation: 0.0,
      title: Text('Sign Up to Brew Crew'),
       actions: [
      TextButton.icon(
        style: TextButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: (){
          widget.toggleView(); // widget refers to register widget
        },
         icon: Icon(Icons.people),
          label:Text('Sign In'),
          ),
      ],
    ),
    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formkey, 
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'), 
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val){
                setState(() => email = val);
              },       
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'), 
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              obscureText: true,
              onChanged: (val){
                 setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Text(
                'Register',
              ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
  
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async{
                     if(_formkey.currentState!.validate()){
                       setState(() => loading = true);
                       dynamic result = await _auth.registerWithEmailPassword(email, password);
                       if(result == null){
                       setState((){
                          error = 'Please supply a valid email';
                          loading = false;
                          });
                       } // if not null automatically home screen because already made it on wrapper
                     } // either true or false
                },
            ),
            SizedBox(height: 12.0,),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0,),
            ),
          ],
        ),
      ),
    //   child: ElevatedButton(
      
    //     child: Text('Sign In Anon'),
    //     onPressed: () async{
    //       dynamic result = await _auth.signInAnon();   //calling signin anon from auth.dart
    //       if(result == null)
    //       {
    //         print('Error Signing In');
    //       }else{
    //         print('Signed In');
    //         print(result.uid);
    //       }
    //     },
    //     style: ElevatedButton.styleFrom(
    //       primary: Colors.grey[500],
    //     ),
     
    // ),
    ),
    );
  }
}