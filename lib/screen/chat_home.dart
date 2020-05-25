import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';
class ChatHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Chat Me',
            style:TextStyle(color: Colors.black)),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ) ,
            onSelected: (String result) {
              if(result=='Logout'){
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              }

            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
               PopupMenuItem<String>(
                value: "Profile",
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.supervised_user_circle,
                      color: Colors.blueAccent,
                    ),
                    Text('Profile'),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value:"Logout",
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.backspace,
                      color: Colors.blueAccent,
                    ),
                    Text('LogOut'),
                  ],
                ),
              ),
            ],
          )
        ],

      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot){
          if(asyncSnapshot.hasError){
            return Center(
              child: Text("Error"),
            );
          }
           if(asyncSnapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Text("Wating......!!!!"),
            );
          }

          else{
             return  ListView.builder(
                 padding: const EdgeInsets.all(8),
                 itemCount: asyncSnapshot.data.documents.length,
                 itemBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ListTile(
                         leading: ClipOval(child: Image.asset('images/default-person.jpg')),
                         title:Text(' ${asyncSnapshot.data.documents[index]['UserName']}') ,
                         onTap: (){
//                           Navigator.of(context).pushNamed('/ChatRoom',
//                           arguments:<String, String> {'sendUser': asyncSnapshot.data
//                               .documents[index]['UserName'],
//                               'sendUserId': asyncSnapshot.data
//                                   .documents[index]['AuthId']
//                           }
//
//                           );

                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => ChatRoom(sendUserId:asyncSnapshot.data.documents[index]['AuthId'] ,
                               sendUser: asyncSnapshot.data.documents[index]['UserName'],),
                             ),
                           );
                         },
                       ),
                     );

                 }
             );
          }

                },
      ),
    );
  }
}
