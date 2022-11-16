import 'package:flutter/material.dart';

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



    );
  }
}
