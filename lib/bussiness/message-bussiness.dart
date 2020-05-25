import 'package:chatapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageBussiness {
  Future<String> SaveMessage(MessageChat mess) async{
    var sendMess= await Firestore.instance.collection("MessageChat").add(
        {
          "Message" : mess.Message,
          "ReceiverId" : mess.ReceiverId,
          "SendId":mess.SendId,
          "DateMessage":new DateTime.now(),
        });
    print('sendMess  ${sendMess.documentID}');
    return sendMess.documentID;
  }
}