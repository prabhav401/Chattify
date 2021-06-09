import 'package:dbms_project/Services/auth.dart';
import 'package:dbms_project/Services/database.dart';
import 'package:dbms_project/Services/helperfunctions.dart';
import 'package:dbms_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'chatRoom.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  signUp(){

    Map<String, String> userInfoMap = {
      "name" : usernameTextEditingController.text,
      "email" : emailTextEditingController.text
    };

    HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
    HelperFunctions.saveUserEmailSharedPreference(usernameTextEditingController.text);



    if (formKey.currentState.validate()){
        setState(() {
          isLoading = true;
        });

        authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
          databaseMethods.uploadUserDetails(userInfoMap);

          Navigator.pushReplacement(context, MaterialPageRoute
            (builder: (context) => ChatRoom()
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Container(
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
                    return val.length < 6 ? "Please provide a valid username (min 6 char)" : null;
                  },
                  controller: usernameTextEditingController,
                  style: simpleTextField(),
                  decoration: textFieldInputDecoration("Enter a username"),
                ),
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
          SizedBox(height : 56.0),
          GestureDetector(
            onTap: (){
              signUp();
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
              child: Text("Sign-Up", style: simpleTextField(),
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
            child: Text("Sign-Up with Google", style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already a registered user ?  ", style: mediumTextField(),),
              GestureDetector(
                onTap: (){
                  widget.toggle();
                },
                child: Text("Sign-In Here", style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80,),
        ],
      ),
    ),
    );
  }
}
