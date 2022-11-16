import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:stable_manager/evenements.dart';
import 'mongodb.dart';

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
      routes: {Evenements.tag: (context) => const Evenements()},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stable Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _test(){
    print('test');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: (
          /*GridButton(
            onPressed: (var test) {
              print('test');
            },
            items: const [
              [
                GridButtonItem(title: "Actus", color: Colors.yellow, flex: 1),
                GridButtonItem(title: "Cours"),
              ],
              [
                GridButtonItem(title: "Evenements", value: "100", flex: 3),
              ],
              [
                GridButtonItem(title: "Cavaliers/Chevaux", value: "100", flex: 1),
              ],
            ]
          )*/
            Column(
              children: [
                TextButton(onPressed: /*() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Actus()),
                  );}*/
                  _test
                      ,child: Text('Actus')),
                TextButton(onPressed: /*() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cours()),
                  );}*/
                _test
                    ,child: Text('Cours')),
                TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Evenements()),
                  );}
                    ,child: Text('Evenements')),
                TextButton(onPressed: /*() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Actus()),
                  );}*/
                _test
                    ,child: Text('Cavaliers')),
              ]
            )
        ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      )
    );
  }
}
