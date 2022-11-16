import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:stable_manager/evenements.dart';
import 'mongodb.dart';

import 'pages/login.dart';
import 'obj/User.dart';
import 'mongodb.dart';
import 'pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDataBase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Evenements.tag: (context) => const Evenements(),
        Signup.tag: (context)=>const Signup(),
        Login.tag: (context)=> const Login(),
      },
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const tag = "home";
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        // actions: [
        //   FloatingActionButton(
        //     tooltip: "sign up",
        //     heroTag: "btnSignUp",
        //
        //     onPressed: () =>{
        //     Navigator.pushNamed(context, Signup.tag)
        //   },
        //     child: Icon(Icons.person_add),
        //   ),
        //   FloatingActionButton(onPressed: ()=>{
        //     Navigator.pushNamed(context, Login.tag)
        //   },
        //     child: Icon(Icons.person),
        //   tooltip: "Login",
        //   heroTag: "btnLogin",)
        // ],
      ),

          // GridButton(
          //   onPressed: (var test) {
          //     print('test');
          //   },
          //   items: const [
          //     [
          //       GridButtonItem(title: "Actus", color: Colors.yellow, flex: 1),
          //       GridButtonItem(title: "Cours"),
          //     ],
          //     [
          //       GridButtonItem(title: "Evenements", value: "100", flex: 3),
          //     ],
          //     [
          //       GridButtonItem(title: "Cavaliers/Chevaux", value: "100", flex: 1),
          //     ],
          //   ]
          // )
        //     Column(
        //       children: [
        //         TextButton(onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const Actus()),
        //           );}
        //           _test
        //               ,child: Text('Actus')),
        //
        //         TextButton(onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const Cours()),
        //           );}
        //         _test
        //             ,child: Text('Cours')),
        //
        //         TextButton(onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const Evenements()),
        //           );}
        //             ,child: Text('Evenements')),
        //
        //         TextButton(onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const Actus()),
        //           );}
        //         _test
        //             ,child: Text('Cavaliers')),
        //       ]
        //     )
        // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),

    );
  }
}
