import 'package:flutter/material.dart';
import 'package:stable_manager/evenements.dart';
import 'package:stable_manager/obj/UserManager.dart';

import '../main.dart';
import '../obj/User.dart';
import 'cavaliers.dart';



class Profile extends StatefulWidget{



  const Profile({super.key});
  @override
  State<StatefulWidget> createState() => _MyProfileState();

}



class _MyProfileState extends State<Profile>{
  int _selectedIndex = 1;
  User currentUser = UserManager.user;

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
  Widget build(BuildContext context){
    return
      Scaffold(
        appBar :AppBar(
          title: Text("Profil"),
        ),

        body:
            Center(
              child: Column(
                children: [

                  Container(
                      margin: const EdgeInsets.all(20),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: NetworkImage(currentUser.picture,),

                      ),
                    ),
                  ),

                  Text(currentUser.name.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black54
                    ),
                  ),

                  Text(currentUser.mail,
                  style: const TextStyle(
                    color: Colors.black54
                  )
                  ),


                  if(currentUser.isOwner == true)...[
                    Text("Propriétaire de l'écurie")
                  ]else...[
                    Text("Régime : " + currentUser.type),
                  ],


                  // Text(((){
                    if (currentUser.type == "Propriétaire")...[
                      Text("Mes chevaux :")
                    ],






                  // })),


                  //Liste des chevaux dont l'user est propriétaire
                ],


              ),
            ),





        //Bottom Nav Bar
        bottomNavigationBar : BottomNavigationBar(
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper,color: Colors.black54,),
              label: 'Actus',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black54,),
              label: 'Profil',


            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.event,color: Colors.black54,),
              label: "Evènements",

            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.people,color: Colors.black54,),
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

