import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_project/Services/auth.dart';
import 'package:dbms_project/Services/database.dart';
import 'package:dbms_project/Services/helperfunctions.dart';
import 'package:dbms_project/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chatRoom.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey <FormState> ();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((
          val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailSharedPreference(
            snapshotUserInfo.docs[0]["name"]);
      });
      authMethods.signInWithEmailAndPassword(
          emailTextEditingController.text, passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute
            (builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                TextFormField(
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please provide a valid E-Mail address.";
                  },
                  controller: emailTextEditingController,
                  style: simpleTextField(),
                  decoration: textFieldInputDecoration("E-Mail"),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val){
                    return val.length < 6 ? "Password size is too small (min 6 char)" :  null;
                  },
                  controller: passwordTextEditingController,
                  style: simpleTextField(),
                  decoration: textFieldInputDecoration("Password"),
                ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(8.0),
              child: Text("Forgot Password ?", style: simpleTextField()),
            ),
            SizedBox(height : 20.0),
            GestureDetector(
              onTap: (){
                signIn();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical : 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Text("Sign-In", style: simpleTextField(),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical : 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text("Sign-In with Google", style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text("Not a registered user ?  ", style: mediumTextField(),),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Text("Register Here", style: TextStyle(
                      color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
