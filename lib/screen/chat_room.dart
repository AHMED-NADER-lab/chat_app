import 'package:chatapp/bussiness/message-bussiness.dart';
import 'package:chatapp/bussiness/user-bussiness.dart';
import 'package:chatapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{
final String sendUser;
final String sendUserId;
final String photo;
  ChatRoom({@required this.sendUser,@required this.sendUserId,this.photo});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
var ObjLoginUser;

final myController = TextEditingController();

   getSharedData() async{
  UserBussiness buss=UserBussiness();
  var result= await buss.GetDateSharedUser();
  return result;
   }


@override
void initState(){
  super.initState();
//   getSharedData().then((data)=>{
//     ObjLoginUser=data
//   });
}


//  List<MessageChat> chat = List<MessageChat>.generate(30, (int index) {
//    return MessageChat(
//        '${index}', '${index}', 'Message ${index}', new DateTime.now());
//  });


//
//  Firestore.instance.collection("MessageChat")
//      .where('SendId',whereIn:[widget.sendUserId,snapshot.data['loginnameId']])
//      .where('ReceiverId',whereIn :[widget.sendUserId,snapshot.data['loginnameId']])
//      .snapshots(),

//      .where('SendId',isEqualTo:widget.sendUserId)
//      .where('SendId',isEqualTo:snapshot.data['loginnameId'])
//      .where('ReceiverId',isEqualTo:widget.sendUserId)
//      .where('ReceiverId',isEqualTo:snapshot.data['loginnameId'])

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.sendUser, style: TextStyle(color: Colors.black)),
      ),
      body: Column(

        children: <Widget>[
          Expanded(
            child: FutureBuilder(
          future: getSharedData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      ObjLoginUser=snapshot.data;
      return StreamBuilder(
          stream: Firestore.instance.collection("MessageChat").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot){
            if(asyncSnapshot.hasError){
              return Center(
                child: Text("Error"),
              );
            }
            if(asyncSnapshot.connectionState==ConnectionState.waiting&& asyncSnapshot.connectionState!=ConnectionState.done){
              return Center(
                child: Text("Wating......!!!!"),
              );
            }

            else{
//             asyncSnapshot.data.documents.sort((a,b) {
//                print('DateMessage DateMessage:::  ${a['DateMessage'] }');
//                return new DateTime.fromMillisecondsSinceEpoch(a['DateMessage'].seconds * 1000) .compareTo(new DateTime.fromMillisecondsSinceEpoch(b['DateMessage'].seconds * 1000));
//              });
              return  ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: asyncSnapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(asyncSnapshot.data.documents[index]['ReceiverId']==widget.sendUserId)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(asyncSnapshot.data.documents[index]['Message']),
                    );
                  });
            }

          }

      );

    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    }

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: TextFormField(
                      controller:myController ,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0, left: 15),
                          hintText: 'Enter Your Message'),
                      cursorColor: Colors.blueAccent,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: ()async{
                    if(ObjLoginUser==null){
                      await getSharedData();
                    }
                    MessageChat model=MessageChat(ObjLoginUser['loginnameId'],widget.sendUserId,myController.text.trim(),new DateTime.now());
                    MessageBussiness mess=MessageBussiness();
                 var resultsave=  await mess.SaveMessage(model);
                 if(resultsave!=null){
                   myController.clear();
                 }
                    print('resultsave resultsave:::  ${resultsave}');
                  },
                  child: const Text('Send', style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//
