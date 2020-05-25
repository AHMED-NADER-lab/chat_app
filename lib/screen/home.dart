import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'imageChat',
                      child: Image.asset('images/multimedia.png',
                        height: MediaQuery.of(context).size.height/4 ,
                        width: MediaQuery.of(context).size.width/2),
                    ),
                    Text('Chat Me',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 50)),
                  ],
                ),
              ),
            ),
           Expanded(
             flex: 1,
             child: Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   SizedBox(
                     width: MediaQuery.of(context).size.width/2 ,
                     height: 50,
                     child: RaisedButton(
                       color: Colors.blueAccent,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                       ),
                       child: Text('Log in',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30)),
                       onPressed: () {
                         Navigator.of(context).pushNamed('/login');
                       },
                     ),
                   ),
                   RichText(
                     text: TextSpan(
                       text: 'Don\'t have an account   ',
                       style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black26),
                       children: [
                         TextSpan(text: 'Register',
                           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),
                           recognizer: TapGestureRecognizer()
                             ..onTap = () =>  Navigator.of(context).pushNamed('/registation'),

                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
           )


          ],
        ),
      ),
    );
  }
}