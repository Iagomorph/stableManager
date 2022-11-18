

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stable_manager/pages/evenements.dart';
import 'package:stable_manager/main.dart';

import 'profile.dart';

class Cavalier extends StatefulWidget{



  const Cavalier({super.key});
  @override
  State<StatefulWidget> createState() => _MyCavalierState();

}

class _MyCavalierState extends State<Cavalier>{
  int _selectedIndex = 3;

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
        break;
      }
    }
  }


  @override
  Widget build(BuildContext context){
    return
        Scaffold(
          appBar :AppBar(
            title: Text("Cavaliers"),
          ),


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

        );
  }
}