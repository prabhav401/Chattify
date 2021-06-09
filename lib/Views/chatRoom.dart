import 'package:dbms_project/Services/NavigationHelper.dart';
import 'package:dbms_project/Services/auth.dart';
import 'package:dbms_project/Services/helperfunctions.dart';
import 'package:dbms_project/Views/searchScreen.dart';
import 'package:dbms_project/modal/Constants.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CHATTIFY", style: TextStyle(fontStyle: FontStyle.italic),),
          actions: [
            GestureDetector(
              onTap: (){
                  authMethods.SignOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => Authentication()));
              },
                child:
                Container(
                    child: Icon(Icons.exit_to_app))),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search_sharp),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => SearchScreen()
            ));
          },
        ),
    );
  }
}
