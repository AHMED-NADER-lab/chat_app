import 'package:chatapp/screen/chat_home.dart';
import 'package:chatapp/screen/chat_room.dart';
import 'package:chatapp/screen/home.dart';
import 'package:chatapp/screen/login.dart';
import 'package:chatapp/screen/registration.dart';
import 'package:flutter/material.dart';

import 'bussiness/user-bussiness.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  UserBussiness user=UserBussiness();
  bool IsRemember= await user.GetDateShared();
  runApp(MyApp(IsRemember));
}

class MyApp extends StatelessWidget {
  final bool IsRemember;
  MyApp(this.IsRemember);

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:!IsRemember? '/':'/ChatHome',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/registation': (context) => Registation(),
        '/ChatHome': (context) => ChatHome(),
        '/ChatRoom': (context) => ChatRoom(),

      },






    );
  }
}






//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.blue,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//            RaisedButton(
//              child: Text('Go!'),
//              onPressed: () {
//                Navigator.of(context).push(_createRoute());
//              },
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//
//
//  Route _createRoute() {
//    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => page2(),
//      transitionDuration: Duration(seconds:4),
//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return RotationTransition(
//         alignment: Alignment.topRight,
//         turns: Tween<double>(
//             begin:0.5, end: 1
//         ).animate(
//             animation
//         ),
//         child: child,
//        );
//      },
//    );
//  }
//}
//
//
//class page2 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.orangeAccent,
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Page 22',
//            ),
//            RaisedButton(
//              child: Text('back!'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}




