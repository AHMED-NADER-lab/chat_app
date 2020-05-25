import 'package:chatapp/model/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBussiness {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CreatNewuser(UserChat _user) async{
    AuthResult regsisterUser=await  _auth.createUserWithEmailAndPassword(email: _user.Email, password: _user.Password);
    print('regsisterUser  ${regsisterUser.user.uid}');
    var saveUser= await Firestore.instance.collection("Users").add(
        {
          "AuthId" : regsisterUser.user.uid,
          "UserName" : _user.UserName,
        });
    print('saveUser  ${saveUser.documentID}');
    _user.Id=saveUser.documentID;
   return _user;
  }

  Login(UserChat _user) async{
    AuthResult res=await  _auth.signInWithEmailAndPassword(email: _user.Email, password: _user.Password);
    var userLogin=await Firestore.instance.collection("Users").where('AuthId',isEqualTo: res.user.uid).getDocuments();
    _user.UserName=userLogin.documents[0]['UserName'];
    _user.AuthId=res.user.uid;
    return _user;
  }
//
//  getCurrentUser() async{
//    FirebaseUser Currentuser=await  _auth.currentUser();
//    var usermodel=UserChat(Currentuser.uid,Currentuser.email,'',false);
//    return usermodel;
//  }

//  CheckUserName(){
//    var res=await  _auth.(email: _user.UserName, password: _user.Password);
//  }

//getAllUser(){
//  Firestore.instance.collection("Users").snapshots();
//}

  Future<bool>  SaveDateShared(String userName, String email, String Authid, bool IsRemember) async{
    var _prefs = await  SharedPreferences.getInstance();
    var loginname= await _prefs.setString('loginname', userName);
    var emailUser= await _prefs.setString('email', email);
    var loginnameId=  await _prefs.setString('AuthId', Authid);
    var IsRememberuser=  await _prefs.setBool('IsRemember', IsRemember);
    if(loginname&&loginnameId&&IsRememberuser&&emailUser){
      return true;
    }
    return false;
  }


  GetDateShared() async{
    var _prefs = await  SharedPreferences.getInstance();
//    var username= await _prefs.getString('loginname');
//    var emailUser= await _prefs.getString('email');
//    var loginnameId=  await _prefs.getString('AuthId');
    bool IsRemember=  await _prefs.getBool('IsRemember');
    return IsRemember==null?false:IsRemember;
  }


  GetDateSharedUser() async{
    var _prefs = await  SharedPreferences.getInstance();
   var username= await _prefs.getString('loginname');
//   var emailUser= await _prefs.getString('email');
  var loginnameId=  await _prefs.getString('AuthId');

    return {'username':username,'loginnameId':loginnameId};
  }


}