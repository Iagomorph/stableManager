import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stable_manager/pages/evenementsForm.dart';
import '../../main.dart';
import 'cavaliers.dart';
import '../mongodb.dart';
import 'profile.dart';
import '../obj/UserManager.dart';

class Evenements extends StatefulWidget{
  static const tag = "evenements";

  const Evenements({super.key});
  @override
  State<Evenements> createState() => _MyEventState();
}

class _MyEventState extends State<Evenements>{
  int _selectedIndex = 2;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });

    switch(_selectedIndex){
      case (0):{
        Navigator.push(context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MyHomePage( title: 'Marie Ecurie',),
              transitionDuration: Duration.zero,
            ));
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
    }
  }

  @override
  void initState() {
    super.initState();
  }

  _orgaBool(type){
    if(type == "soiree"){
      return true;
    }else{
      return false;
    }
  }
  _coursBool(type){
    if(type == "cours"){
      return true;
    }else{
      return false;
    }
  }

  _isParticipating(participants){
    if(participants.contains(UserManager.user.token)){
      return true;
    }else{return false;}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evenements"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EvenementsForm()),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: "Evènements",


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
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            FutureBuilder(
              future: MongoDataBase.getEvents(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Image.network(
                                  snapshot.data[index].img,
                                  fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Image.network("https://thndl.com/images/5_2.jpg", fit: BoxFit.contain);
                                  },
                                ),
                                title: Text(snapshot.data[index].name, style: TextStyle(fontSize: 25),),
                                subtitle: Text(snapshot.data[index].desc, style: TextStyle(fontSize: 20),),
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Date: '+snapshot.data[index].date, style: TextStyle(fontSize: 15),),
                                  Visibility(
                                    visible: _orgaBool(snapshot.data[index].type),
                                    child: Text('Organisateur: '+snapshot.data[index].organisateur, style: TextStyle(fontSize: 15),)
                                  ),
                                  Visibility(
                                      visible: _coursBool(snapshot.data[index].type),
                                      child: Text('Terrain: '+snapshot.data[index].terrain, style: TextStyle(fontSize: 15),)
                                  ),
                                  Visibility(
                                      visible: _coursBool(snapshot.data[index].type),
                                      child: Text('Discipline: '+snapshot.data[index].discipline, style: TextStyle(fontSize: 15),)
                                  ),
                                  Text('Status: '+snapshot.data[index].status, style: TextStyle(fontSize: 15),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Visibility(
                                    visible: UserManager.user.isOwner,
                                    child: TextButton(
                                      child: const Text('VALIDER'),
                                      onPressed: () {
                                        setState(() {
                                          MongoDataBase.updateEventStatus(snapshot.data[index].token, 'validated');
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Visibility(
                                    visible: UserManager.user.isOwner,
                                    child: TextButton(
                                      child: const Text('ANNULER'),
                                      onPressed: () {
                                        setState(() {
                                          MongoDataBase.updateEventStatus(snapshot.data[index].token, 'cancelled');
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Visibility(
                                      visible: _isParticipating(snapshot.data[index].participants),
                                      child: TextButton(
                                        child: const Text('NE PLUS PARTICIPER'),
                                        onPressed: () {
                                          setState(() {
                                            MongoDataBase.removeEventParticipant(snapshot.data[index].token, UserManager.user.token);
                                          });
                                        },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Visibility(
                                    visible: !_isParticipating(snapshot.data[index].participants),
                                    child: TextButton(
                                      child: const Text('PARTICIPER'),
                                      onPressed: () {
                                        setState(() {
                                          MongoDataBase.addEventParticipant(snapshot.data[index].token, UserManager.user.token);
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('COMMENTAIRES'),
                                    onPressed: () {/* ... */},
                                  ),
                                ],
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
                      child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 15)),
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
            )
          ]
        )
      ),
    );
  }
}