import 'package:chatapp/bussiness/user-bussiness.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';
class ChatHome extends StatelessWidget {
  getSharedData() async{
    UserBussiness buss=UserBussiness();
    var result= await buss.GetDateSharedUser();
    return result;
  }
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
      body: FutureBuilder(
        future: getSharedData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
         return  StreamBuilder(
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
               return ListView(
                   children:  asyncSnapshot.data.documents.map((e){
                     if(e['AuthId']!=snapshot.data['loginnameId']){
                       return   ListTile(
                         leading: CircleAvatar(
                             backgroundImage: new NetworkImage(e['photourl'])),
                         title:Text(' ${e['UserName']}'),
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => ChatRoom(sendUserId:e['AuthId'] ,
                                   sendUser: e['UserName'],photo:e['photourl']),
                             ),
                           );
                         },
                       );
                     }
                     else{
                       return  Container();
                     }

                   }

                   ).toList()
               ) ;



//               ListView.builder(
////                 padding: const EdgeInsets.all(8),
////                 itemCount: asyncSnapshot.data.documents.length,
////                 itemBuilder: (BuildContext context, int index) {
////                     return Padding(
////                       padding: const EdgeInsets.all(8.0),
////                       child: ListTile(
////
////                         leading: CircleAvatar(
////                             backgroundImage: new NetworkImage(asyncSnapshot.data.documents[index]['photourl'])),
////
////
////                         title:Text(' ${asyncSnapshot.data.documents[index]['UserName']}') ,
////                         onTap: (){
//////                           Navigator.of(context).pushNamed('/ChatRoom',
//////                           arguments:<String, String> {'sendUser': asyncSnapshot.data
//////                               .documents[index]['UserName'],
//////                               'sendUserId': asyncSnapshot.data
//////                                   .documents[index]['AuthId']
//////                           }
//////
//////                           );
////
////                           Navigator.push(
////                             context,
////                             MaterialPageRoute(
////                               builder: (context) => ChatRoom(sendUserId:asyncSnapshot.data.documents[index]['AuthId'] ,
////                                   sendUser: asyncSnapshot.data.documents[index]['UserName'],photo:asyncSnapshot.data.documents[index]['photourl']),
////                             ),
////                           );
////                         },
////                       ),
////                     );
////
////
////
////                 }
////             );
             }

           },
         );
    }

      ),
    );
  }
}
