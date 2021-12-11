import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  // _ means private
  final FirebaseAuth _auth = FirebaseAuth.instance;  //returns firebaseauth

  // Create user object based on FirebaseUser
  TheUser? _userFromFirebaseUser(User? user){
      return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<TheUser?> get user {
    return _auth.authStateChanges() //return firebase users whenever there is change in authentication
    //.map((User? user) => _userFromFirebaseUser(user));  // returns custom user model
    .map(_userFromFirebaseUser); // same as above line
  }


  // Sign In anonymously
  Future signInAnon() async{
  try{
    UserCredential result = await _auth.signInAnonymously();   //returns UserCredential   ----   result can be any name
    User? user = result.user;
    return _userFromFirebaseUser(user);
}
  catch(e){
    print(e.toString());
     return null;
  }

  }

  // Sign In with email & password
 Future signInWithEmailPassword(String email, String password) async{
try{
  UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);  // email and password from string
  User? user = result.user;
  return _userFromFirebaseUser(user);
}
catch(e){
 print(e.toString());
 return null;
}
  }

  // Register with email & password
  Future registerWithEmailPassword(String email, String password) async{
try{
  UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);  // email and password from string
  User? user = result.user;
  // create a new document for the user with the uid
  await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member',100);
  //
  return _userFromFirebaseUser(user);
}
catch(e){
 print(e.toString());
 return null;
}
  }


  // Sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
    }
  }