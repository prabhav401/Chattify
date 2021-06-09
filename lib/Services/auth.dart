import 'package:firebase_auth/firebase_auth.dart';
import 'package:dbms_project/modal/user.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _userFromFirebaseUser(User user){
    return user != null ? FirebaseUser(userID : user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }
  Future signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }
  Future resetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  Future SignOut() async {
    try{
        return await _auth.signOut();
    } catch(e){

    }
  }
}
