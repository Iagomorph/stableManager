

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stable_manager/pages/evenements.dart';
import 'package:stable_manager/main.dart';

import '../mongodb.dart';
import '../obj/User.dart';
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: MongoDataBase.getUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      print("Total data$totalData");

                      return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) =>
                            displayUser(snapshot.data[index]),
                        itemCount: snapshot.data.length,
                      );

                      // return ListView.builder(
                      //     itemCount:snapshot.data.length,
                      //     itemBuilder: (context, index){
                      //       return displayUser(
                      //           snapshot.data[index]
                      //       );
                      //     }
                      // );
                    } else {
                      return const Center(
                        child: Text("no data avalaible"),
                      );
                    }
                  }
                },
              ),
            ),
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
  Widget displayUser(User data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.blueGrey,
            leading: const Icon(Icons.person),
            title: Text(data.name),
            trailing: const Icon(
              Icons.menu,
            ),
          ),
          footer: const GridTileBar(
            backgroundColor: Colors.blueGrey,
            leading: Icon(Icons.delete),
          ),
          child: Image.network(
            data.picture,
            fit: BoxFit.cover,
          )),
    );
  }
}