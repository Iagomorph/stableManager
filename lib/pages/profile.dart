

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stable_manager/evenements.dart';
import 'package:stable_manager/obj/UserManager.dart';
import 'package:stable_manager/pages/editprofile.dart';

import '../main.dart';
import '../mongodb.dart';
import '../obj/Horse.dart';
import '../obj/User.dart';
import 'cavaliers.dart';



class Profile extends StatefulWidget{



  const Profile({super.key});
  @override
  State<StatefulWidget> createState() => _MyProfileState();

}



class _MyProfileState extends State<Profile> {
  List<Horse> Horses = [];
  List<Horse> allHorses = [];
  String _dropDownValue = "dressage";

  void _awaitReturnFromEdit(BuildContext context) async {
    //on attends la réponse de la deuxième page avec le .push
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          //on build à partir de la secondpage
          builder: (context) => const EditProfile(),
        )
    );
    setState(() {
      //on add la carte qu'on a recup
      Horses.add(result);
    });
  }


  void getUserHorses() async {
    Horses = await MongoDataBase.getUserHorses(currentUser.token);
    print(Horses);
  }

  void getHorses() async {
    allHorses = await MongoDataBase.getHorses();
    print(allHorses);
}

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
      });
    }
  }

  final horseNameController = TextEditingController();
  final horseImgController = TextEditingController();
  final horseAgeController = TextEditingController();
  final horseRobeController = TextEditingController();
  final horseRaceController = TextEditingController();
  final horseSexeController = TextEditingController();

  int _selectedIndex = 1;
  User currentUser = UserManager.user;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });





    switch (_selectedIndex) {
      case (0):
        {
          Navigator.push(context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                const MyHomePage(title: 'Marie Ecurie',),
                transitionDuration: Duration.zero,
              ));
          break;
        }
      case (1):
        {
          break;
        }
      case(2):
        {
          Navigator.push(context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const Evenements(),
                transitionDuration: Duration.zero,
              ));
          break;
        }
      case(3):
        {
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
    getUserHorses();
    getHorses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),

        body:
        SingleChildScrollView(
          child: Center(
            child:
            Column(
              children: [
                //Profil user
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

                //TAG DP/PROPRIO || OWNER
                if(currentUser.isOwner == true)...[
                  Text("Propriétaire de l'écurie")
                ] else
                  ...[
                    Text("Régime : " + currentUser.type),
                  ],
                Text("Mes chevaux :"),

                FutureBuilder(
                  //liste chevaux
                  future: MongoDataBase.getUserHorses(currentUser.token),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return  const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasData){
                      var totalData = snapshot.data.length;
                      return
                        ListView.builder(physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: totalData,
                          itemBuilder: (context,index){
                            return
                              Card(
                              child: Column(
                                children: [
                                  Row(children: [
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data[index].image),
                                        ),
                                      ),
                                    ),
                                    Text(snapshot.data[index].nom)
                                  ],),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("race : " + snapshot.data[index].race),
                                          Text("robe : " + snapshot.data[index].robe),
                                          Text("sexe : " + snapshot.data[index].sexe)
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("age : " + snapshot.data[index].age.toString()),
                                          Text("specialité : " + snapshot.data[index].spec),
                                        ],
                                      ),
                                      //bouton edit
                                      ElevatedButton(onPressed: (){
                                        horseNameController.value = TextEditingValue(text: snapshot.data[index].nom);
                                        horseSexeController.value = TextEditingValue(text: snapshot.data[index].sexe);
                                        horseAgeController.value = TextEditingValue(text: snapshot.data[index].age.toString());
                                        horseRobeController.value = TextEditingValue(text: snapshot.data[index].robe);
                                        horseImgController.value = TextEditingValue(text: snapshot.data[index].image);
                                        horseRaceController.value = TextEditingValue(text: snapshot.data[index].race);
                                        showDialog(context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Form(child: Column(
                                                    children: [
                                                      Text("Ajouter Mon propre cheval"),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "nom",
                                                          hintText: "Entrez le nom de votre cheval"
                                                      ),
                                                        controller: horseNameController,
                                                      ),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "photo",
                                                          hintText: "Entrez une photo de votre cheval"
                                                      ),
                                                        controller: horseImgController,
                                                      ),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "Age",
                                                          hintText: "Entrez l'age de votre cheval"
                                                      ),
                                                        controller: horseAgeController,
                                                      ),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "robe",
                                                          hintText: "Entrez la couleur de la robe de votre cheval"
                                                      ),
                                                        controller: horseRobeController,
                                                      ),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "race",
                                                          hintText: "Entrez la race de votre cheval"
                                                      ),
                                                        controller: horseRaceController,
                                                      ),

                                                      TextFormField(decoration:
                                                      const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "sexe",
                                                          hintText: "Entrez le sexe de votre cheval"
                                                      ),
                                                        controller: horseSexeController,
                                                      ),

                                                      DropdownButtonFormField(items: const[
                                                        DropdownMenuItem(child: Text("Dressage"),
                                                          value: "dressage",),
                                                        DropdownMenuItem(child: Text("Endurance"),
                                                          value: "endurance",),
                                                        DropdownMenuItem(
                                                          child: Text("Complet"), value: "Complet",),
                                                        DropdownMenuItem(
                                                          child: Text("Saut d'obstacle"),
                                                          value: "Saut d'obstacle",)
                                                      ], onChanged: dropdownCallback,
                                                        value: _dropDownValue,
                                                      ),

                                                      ElevatedButton(onPressed: () async {
                                                        String name = horseNameController.text;
                                                        String img = horseImgController.text;
                                                        int age = int.parse(horseAgeController.text);
                                                        String robe = horseRobeController.text;
                                                        String race = horseRaceController.text;
                                                        String sexe = horseSexeController.text;
                                                        String spec = _dropDownValue;
                                                        String uid = currentUser.token;
                                                        String DpUser = snapshot.data[index].DpUser;

                                                        Horse horse = Horse(
                                                            uid,
                                                            img,
                                                            name,
                                                            age,
                                                            robe,
                                                            race,
                                                            sexe,
                                                            spec,
                                                          DpUser
                                                            );
                                                        await MongoDataBase.updateHorse(horse, currentUser);
                                                        Horses.add(horse);
                                                        setState(() {
                                                          Horses.add(horse);
                                                        });

                                                        Navigator.pop(context, horse);

                                                      }, child: Text("Modifier les infos de votre cheval"))

                                                    ],
                                                  ))
                                              );
                                            }
                                        );
                                      }, child: Icon(Icons.mode))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }else{
                      return const Center(
                          child: Text("no data avaible")
                      );
                    }

                    // );}
                  },),


                //FORM DAJOUT DE CHEVAL SI PROPRIO
                if (currentUser.type == "Propriétaire")...[

                  ElevatedButton(onPressed: () {
                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                              content: Form(child: Column(
                                children: [
                                  Text("Ajouter Mon propre cheval"),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "nom",
                                      hintText: "Entrez le nom de votre cheval"
                                  ),
                                    controller: horseNameController,
                                  ),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "photo",
                                      hintText: "Entrez une photo de votre cheval"
                                  ),
                                    controller: horseImgController,
                                  ),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Age",
                                      hintText: "Entrez l'age de votre cheval"
                                  ),
                                    controller: horseAgeController,
                                  ),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "robe",
                                      hintText: "Entrez la couleur de la robe de votre cheval"
                                  ),
                                    controller: horseRobeController,
                                  ),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "race",
                                      hintText: "Entrez la race de votre cheval"
                                  ),
                                    controller: horseRaceController,
                                  ),

                                  TextFormField(decoration:
                                  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "sexe",
                                      hintText: "Entrez le nom de votre cheval"
                                  ),
                                    controller: horseSexeController,
                                  ),

                                  DropdownButtonFormField(items: const[
                                    DropdownMenuItem(child: Text("Dressage"),
                                      value: "dressage",),
                                    DropdownMenuItem(child: Text("Endurance"),
                                      value: "endurance",),
                                    DropdownMenuItem(
                                      child: Text("Complet"), value: "Complet",),
                                    DropdownMenuItem(
                                      child: Text("Saut d'obstacle"),
                                      value: "Saut d'obstacle",)
                                  ], onChanged: dropdownCallback,
                                    value: _dropDownValue,
                                  ),

                                  ElevatedButton(onPressed: () async {
                                    String name = horseNameController.text;
                                    String img = horseImgController.text;
                                    int age = int.parse(horseAgeController.text);
                                    String robe = horseRobeController.text;
                                    String race = horseRaceController.text;
                                    String sexe = horseSexeController.text;
                                    String spec = _dropDownValue;
                                    String uid = currentUser.token;

                                    Horse horse = Horse(
                                        uid,
                                        img,
                                        name,
                                        age,
                                        robe,
                                        race,
                                        sexe,
                                        spec);
                                    await MongoDataBase.addHorse(horse);
                                    setState(() {
                                      Horses.add(horse);
                                    });

                                    Navigator.pop(context, horse);

                                  }, child: Text("Ajoutez votre cheval"))

                                ],
                              ))
                          );
                        }
                        );
                  }, child: Icon(Icons.add))
                ],
                if (currentUser.type == "DP")...[
                  FutureBuilder(
                    //liste chevaux
                    future: MongoDataBase.getUserDpHorses(currentUser.token),
                    builder: (BuildContext context,
                        AsyncSnapshot snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return  const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.hasData){
                        var totalData = snapshot.data.length;
                        return
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: totalData,
                              itemBuilder: (context,index){
                                return
                                  Card(
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Container(
                                            margin: const EdgeInsets.all(20),
                                            width: 90,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot.data[index].image),
                                              ),
                                            ),
                                          ),
                                          Text(snapshot.data[index].nom)
                                        ],),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text("race : " + snapshot.data[index].race),
                                                Text("robe : " + snapshot.data[index].robe),
                                                Text("sexe : " + snapshot.data[index].sexe)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("age : " + snapshot.data[index].age.toString()),
                                                Text("specialité : " + snapshot.data[index].spec),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                              });
                      }else{
                        return const Center(
                            child: Text("no data avaible")
                        );
                      }

                      // );}
                    },),

                  ElevatedButton(onPressed: () async {
                    final result = await Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const EditProfile()));

                    setState(() {
                      Horses.add(result);
                    });
                  },
                  child: Icon(Icons.add))
                ],




              ],
            ),
          ),
        ),


        //Bottom Nav Bar
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

      );
  }
}

