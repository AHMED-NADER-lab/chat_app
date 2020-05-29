import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child:
                LayoutBuilder(builder: (ctr,constrant){
                    return MediaQuery.of(context).orientation==Orientation.portrait?
                    Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Hero(
                  tag: 'imageChat',
                    child: Image.asset('images/multimedia.png',
                        height: constrant.maxHeight*0.6),
                  ),

                  Container(
                      height: constrant.maxHeight*0.2,
                      child: Text('Chat Me',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 50))),
                  ],
                  ):
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'imageChat',
                          child: Image.asset('images/multimedia.png',
                              width: constrant.maxWidth*0.4,
                          ),
                        ),

                        Container(
                            width: constrant.maxWidth*0.5,
                            child:
                            Text('Chat Me',
                                style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 50)
                            )
                        ),
                      ],
                    );
                })

              ),
            ),
           Expanded(
             child: Container(
                 width: MediaQuery.of(context).size.width,
               child:
               LayoutBuilder(builder: (ctr,constrant){
                 return   Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     SizedBox(
                       width: constrant.maxWidth*0.7 ,
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
                     Container(
                       child: RichText(
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
                       ),
                       height: constrant.maxHeight*0.2,
                     )
                   ],
                 );
               })
             ),
           )


          ],
        ),
      ),
    );
  }
}