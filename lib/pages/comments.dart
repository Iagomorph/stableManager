import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stable_manager/pages/evenementsForm.dart';
import '../../main.dart';
import 'cavaliers.dart';
import '../mongodb.dart';
import 'profile.dart';
import '../obj/UserManager.dart';
import 'evenements.dart';
import 'commentsForm.dart';

class Comments extends StatefulWidget{

  final String eventToken;

  static const tag = "comments";

  const Comments(this.eventToken, {super.key});
  @override
  State<Comments> createState() => _MyCommentState(eventToken);
}

class _MyCommentState extends State<Comments>{

  final String eventToken;
  _MyCommentState(this.eventToken);

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
        title: const Text("Commentaires"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommentsForm(eventToken)),
              ).then((_) {
                setState(() {});
              });;
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
                  future: MongoDataBase.getComments(eventToken),
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
                                    title: Text(snapshot.data[index].username, style: TextStyle(fontSize: 25),),
                                    subtitle: Text(snapshot.data[index].message, style: TextStyle(fontSize: 20),),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Visibility(
                                        visible: UserManager.user.isOwner,
                                        child: TextButton(
                                          child: const Text('SUPPRIMER'),
                                          onPressed: () {
                                            setState(() {
                                              MongoDataBase.updateEventStatus(snapshot.data[index].token, 'validated');
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ]
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
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          //child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 15)),
                          child: Text("Cet évènement n'a aucun commentaire.", style: TextStyle(fontSize: 15)),
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