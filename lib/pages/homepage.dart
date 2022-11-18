import 'package:flutter/material.dart';
import 'package:stable_manager/pages/profile.dart';

import '../evenements.dart';
import '../mongodb.dart';
import 'cavaliers.dart';

class MyHomePage extends StatefulWidget {
  static const tag = "home";

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case (0):
        {
          break;
        }
      case (1):
        {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const Profile(),
                transitionDuration: Duration.zero,
              ));
          break;
        }
      case (2):
        {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const Evenements(),
                transitionDuration: Duration.zero,
              ));
          break;
        }
      case (3):
        {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const Cavalier(),
                transitionDuration: Duration.zero,
              ));
          break;
        }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper,
              color: Colors.black54,
            ),
            label: 'Actus',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black54,
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: Colors.black54,
            ),
            label: "Evènements",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.black54,
            ),
            label: "Cavaliers",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}

_imgBool(type) {
  if (type == "cours") {
    return false;
  } else {
    return true;
  }
}

_orgaBool(type) {
  if (type == "soiree") {
    return true;
  } else {
    return false;
  }
}

_coursBool(type) {
  if (type == "cours") {
    return true;
  } else {
    return false;
  }
}
