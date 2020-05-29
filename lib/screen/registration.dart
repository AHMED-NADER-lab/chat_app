import 'package:chatapp/bussiness/user-bussiness.dart';
import 'package:chatapp/model/user_chat.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/bussiness/picker-bussiness.dart';

class Registation extends StatefulWidget {
  @override
  _RegistationState createState() => _RegistationState();
}

class _RegistationState extends State<Registation> {
  final _formKey = GlobalKey<FormState>();
  String UserName;
  String Email;
  String Password;
  var photodata;
  bool isphoto=false;
  GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey();
  UserBussiness buss=UserBussiness();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body:Center(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: 'imageChat',
              child: Image.asset('images/multimedia.png',
                height: 150,
                width: 150,),
            ),
            Form(
              key:_formKey ,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,top: 20,bottom: 30,right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 60,
                      child: TextFormField(
                          decoration: InputDecoration(
                         border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0,left: 15),
                              prefixIcon: const Icon(
                                Icons.supervised_user_circle,
                                color: Colors.blueAccent,
                              ),
                              hintText: 'Enter Your UserName'

                          ),
                          cursorColor: Colors.blueAccent,
                          onSaved: (value){
                            UserName=value.trim();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'this Feild Is Required';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(
                      height: 25
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 60,
                      child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0,left: 15),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.blueAccent,
                              ),
                              hintText: 'Enter Your Email'
                          ),

                          cursorColor: Colors.blueAccent,
                          onSaved: (value){
                            Email=value.trim();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'this Feild Is Required';
                            }else if(!value.trim().contains('@')){
                              return 'Enter Valid Email';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 60,
                      child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0,left: 15),
                              prefixIcon: const Icon(
                                Icons.vpn_key,
                                color: Colors.blueAccent,
                              ),
                              hintText: 'Enter Your Password'

                          ),
                          cursorColor: Colors.blueAccent,
                          obscureText: true,
                          onSaved: (value){
                            Password=value.trim();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'this Feild Is Required';
                            }
                           else if (value.trim().length<6) {
                              return 'Enter Valid Password more than 6 char';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        onPressed: () async {
                          var file=filePikerBussiness();
                       var resultPhoto   =  await file.filePicker(context);
                          setState(() {
                            photodata =resultPhoto;
                          });
                        },
                       child: Text(photodata==null?'Choose Your Image':photodata['filename'],
                          style: TextStyle(fontSize: 20)
                      ),

                    ),

                    isphoto?
                    Text('Please Choose your Photo',
                        style: TextStyle(color:Colors.red)
                        ): Text('Please Choose your Photo',
                      style: TextStyle(color:Colors.transparent))


                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30,left: 30,right: 30),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()&&photodata!=null) {
                      try{
//                      setState(() {
//                        _saving=true;
//                      });
                     _formKey.currentState.save();
                   var usermodel=UserChat('',UserName,photodata['filename'],Password,Email);
                     UserChat res=await buss.CreatNewuser(usermodel,photodata['file']);
                   if(res.Id!='')  {
                     _ScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Save Success Please Login with new Account"),
                     duration: Duration(seconds: 3),));
                     new Future.delayed( Duration(seconds: 3), () {
                       Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
                     });
                   }

//                      setState(() {
//                        _saving=false;
//                      });
                      }
                      catch(ex){
                        print('vvvvvvvv ${ex.code}');
                        var errorMessage='';
                        switch (ex.code) {
                          case "ERROR_INVALID_EMAIL":
                            errorMessage = "Your email address appears to be malformed.";
                            break;
                          case "ERROR_WRONG_PASSWORD":
                            errorMessage = "Your password is wrong.";
                            break;
                          case "ERROR_USER_NOT_FOUND":
                            errorMessage = "User with this email doesn't exist.";
                            break;
                          case "ERROR_USER_DISABLED":
                            errorMessage = "User with this email has been disabled.";
                            break;
                          case "ERROR_TOO_MANY_REQUESTS":
                            errorMessage = "Too many requests. Try again later.";
                            break;
                          case "ERROR_OPERATION_NOT_ALLOWED":
                            errorMessage = "Signing in with Email and Password is not enabled.";
                            break;
                          case "ERROR_EMAIL_ALREADY_IN_USE":
                            errorMessage = "This Email already used";
                            break;

                          default:
                            errorMessage = "An undefined Error happened.";
                        }
                   _ScaffoldKey.currentState.showSnackBar(SnackBar(content: Text(errorMessage)));
//
//                      setState(() {
//                        _saving=false;
//                      });
                      }

                    }else{
                      if(photodata==null){
                        setState(() {
                          isphoto=true;
                        });
                      }
                    }
                  },
                  child:const Text(
                      'Save',
                      style: TextStyle(fontSize: 20)
                  ),
                  color: Colors.blueAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
