import 'package:chatapp/bussiness/user-bussiness.dart';
import 'package:chatapp/model/user_chat.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String Email;
  String Password;
  bool IsRemember=true;
  UserBussiness buss=UserBussiness();
  GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_ScaffoldKey ,
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0,left: 15),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.blueAccent,
                            ),
                           // labelText: 'Email',
                          hintText: 'Enter Your Email',


                          ),
                          cursorColor: Colors.blueAccent,
                          onSaved: (value){
                            Email=value.trim();
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
                            return null;
                          }
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value:IsRemember,
                          checkColor: Colors.white,
                          activeColor: Colors.blueAccent,
                          onChanged: (value) {
                            setState(() { IsRemember = value; });
                          },
                        ),
                        Text('Remember Me'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () async {
//                          return;
                    if (_formKey.currentState.validate()) {
                      try{
//                      setState(() {
//                        _saving=true;
//                      });
                     _formKey.currentState.save();
                     var usermodel=UserChat('',"",'',Password,Email);
                     UserChat res=await buss.Login(usermodel);
                     if(res.AuthId!=null)  {
                       bool resShared=await buss.SaveDateShared(res.UserName,res.Email,res.AuthId,IsRemember);
                       if(resShared){
                         Navigator.of(context).pushNamedAndRemoveUntil('/ChatHome', (Route<dynamic> route) => false);

                       }else{
                         _ScaffoldKey.currentState.showSnackBar(SnackBar(content: Text('An error has occurred, possible to try again')));

                       }

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

                    }
                  },
                  child:const Text(
                      'Log in',
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
