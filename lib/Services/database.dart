import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("AppUsers")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance.collection("AppUsers")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserDetails(userMap){
     FirebaseFirestore.instance.collection("AppUsers")
         .add(userMap);
  }

  createChatRoom(String roomID, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(roomID).set(chatRoomMap).catchError((e){
          print(e.toString());
    });
    }
  }
