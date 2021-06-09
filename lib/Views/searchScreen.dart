import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_project/Services/database.dart';
import 'package:dbms_project/Views/convoScreen.dart';
import 'package:dbms_project/modal/Constants.dart';
import 'package:dbms_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  // ignore: non_constant_identifier_names
  TextEditingController SearchUsernameText = new TextEditingController();
  QuerySnapshot searchSnapshot;

  startSearch(){
    databaseMethods.getUserByUsername(SearchUsernameText.text)
        .then((val){
        setState(() {
          searchSnapshot = val;
        });
    });
  }

  createChatRoomWindow(String username){

    String chatroomid = getChatRoomId(username, Constants.myName);

    List<String> users = [username, Constants.myName];
    Map <String, dynamic> chatRoomApp = {
      "AppUsers" : users,
      "chatroomid" : chatroomid,
    };

    databaseMethods.createChatRoom(chatroomid, chatRoomApp);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationScreen();
    ));
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTiles(
            usernameDB: searchSnapshot.docs[index]["name"],
            emailDB: searchSnapshot.docs[index]["email"],
          );
        }) : Container();
  }

  @override
  void initState() {
    startSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal : 20.0, vertical: 8.0),
              child: Row(
                children: [
                Expanded(
                    child: TextField(
                      controller: SearchUsernameText,
                      decoration: InputDecoration(
                        hintText: "Search Username...",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 16.0, color: Colors.black, ),
                    )
                ),
                  GestureDetector(
                    onTap: (){
                          startSearch();
                    },
                      child:
                        Icon(Icons.search, color: Colors.white),
                  ),
              ],),
              ),
            searchList(),
          ],
        ),
      )
    );
  }
}


class SearchTiles extends StatelessWidget {

  final String usernameDB;
  final String emailDB;
  SearchTiles({this.usernameDB, this.emailDB});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Text(usernameDB, style: simpleTextField()),
              Text(emailDB, style: simpleTextField()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text("Message"),

            ),
          ),
        ],
      ),
    );
  }
}


getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
