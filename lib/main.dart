import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:stable_manager/pages/evenements.dart';
import 'package:stable_manager/pages/profile.dart';
import 'mongodb.dart';

import 'pages/cavaliers.dart';
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
  int _selectedIndex = 0;


void _onItemTapped(int index){
  setState(() {
    _selectedIndex = index;
  });

  switch(_selectedIndex){
    case (0):{
      break;
    }
    case (1): {
      Navigator.push(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Profile(),
            transitionDuration: Duration.zero,
          ));
      break;
    }
    case(2): {
      Navigator.push(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Evenements(),
            transitionDuration: Duration.zero,
          ));
      break;
    }
    case(3): {
      Navigator.push(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Cavalier(),
            transitionDuration: Duration.zero,
          )
      );
      break;
    }
    break;



  };

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar :AppBar(
        title: Text(widget.title),
      ),

      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: MongoDataBase.getLog(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        ListView.builder(
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      snapshot.data[index].type,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    subtitle: (snapshot.data[index].user != null)
                                        ? Text(
                                      snapshot.data[index].user,
                                      style: TextStyle(fontSize: 20),
                                    )
                                        : (snapshot.data[index].user != null)
                                        ? Text(
                                      snapshot.data[index].event,
                                      style: TextStyle(fontSize: 20),
                                    )
                                        : null,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ];
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                      ];
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    );
                  },
                ),
              ])),
      //FIN DE L'APPBAR MERCI DE METTRE VOTRE CODE SOUS CE MSG ET AU DESSUS DE LA NAVBAR DU BAS




      //NAVBAR DU BAS MERCI DE METTRE VOTRE CODE AU DESSUS DE CA ET SOUS L'APPBAR
          bottomNavigationBar : BottomNavigationBar(
            items: const<BottomNavigationBarItem>[
              BottomNavigationBarItem(

                  icon: Icon(Icons.newspaper, color: Colors.black54,),
                  label: 'Actus',
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.black54,),
                  label: 'Profil',

              ),

              BottomNavigationBarItem(

                  icon: Icon(Icons.event, color: Colors.black54,),
                  label: "Ev??nements",


              ),

              BottomNavigationBarItem(

                  icon: Icon(Icons.people, color: Colors.black54,),
                  label: "Cavaliers",

              )
            ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

          selectedItemColor: Colors.blue,

          ),
    );


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


  }
}
