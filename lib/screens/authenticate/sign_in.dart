import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
   final Function toggleView;   // constructor of parameter from authenticate
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();  // calling an instance of authservice class from auth.dart 
final _formkey = GlobalKey<FormState>(); // key formstate
bool loading = false;

// text field state
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
      title: Text('Sign In to Brew Crew'),
      actions: [
      TextButton.icon(
        style: TextButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: (){
          widget.toggleView();
        },
         icon: Icon(Icons.people),
          label:Text('Register'),
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
                'Sign In',
              ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
  
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async{
                   if(_formkey.currentState!.validate()){
                     setState(() => loading =true);
                     dynamic result = await _auth.signInWithEmailPassword(email, password);
                     if(result == null){
                       setState((){
                          error = 'could not sign in with those credentials';
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