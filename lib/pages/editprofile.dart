import 'package:flutter/material.dart';
import 'package:stable_manager/obj/UserManager.dart';
import '../mongodb.dart';
import '../obj/Horse.dart';

class EditProfile extends StatefulWidget{

  const EditProfile({super.key});
  @override
  State<StatefulWidget> createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<EditProfile>{
  List<Horse> allHorses = [];
  List<Horse> Horses = [];

  void getHorses() async {
    allHorses = await MongoDataBase.getHorses();
    print(allHorses);
  }


  @override
  void initState() {
    getHorses();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: MongoDataBase.getHorses(),
            builder: (BuildContext context,
                AsyncSnapshot snapshot) {
              // List<Widget> children;
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
                                    ),
                                    ElevatedButton(onPressed: () async {
                                      Horse horse = snapshot.data[index];
                                      await MongoDataBase.updateHorseDp(horse, horse.userId, UserManager.user.token);

                                      Navigator.pop(context, horse);
                                    }, child: Icon(Icons.add)),
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
        ],
      ),
    );
  }
}