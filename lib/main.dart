import 'package:flutter/material.dart';
import 'package:stable_manager/evenements.dart';

import 'mongodb.dart';
import 'pages/login.dart';
import 'pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDataBase.connect();
  runApp(const MyApp());
}

// class CustomRoute<T> extends MaterialPageRoute<T> {
//   CustomRoute({ WidgetBuilder builder, RouteSettings settings })
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//       return child;
//   }
// }

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
        Signup.tag: (context) => const Signup(),
        Login.tag: (context) => const Login(),
      },
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
