import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stable_manager/evenementsForm.dart';
import 'eventClass.dart';
import 'mongodb.dart';

class Evenements extends StatefulWidget {
  static const tag = "evenements";

  const Evenements({super.key});

  @override
  State<Evenements> createState() => _AllEvenements();
}

class _AllEvenements extends State<Evenements> {
  @override
  void initState() {
    super.initState();
  }

  _imgBool(type){
    if(type == "cours"){
      return false;
    }else{
      return true;
    }
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

  @override
  void initState() {
    super.initState();
  }

  _imgBool(type){
    if(type == "cours"){
      return false;
    }else{
      return true;
    }
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
                                leading: Visibility(
                                  visible: _imgBool(snapshot.data[index].type),
                                  child: Image.network(
                                    snapshot.data[index].img,
                                    fit: BoxFit.contain,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return Image.network("https://thndl.com/images/5_2.jpg", fit: BoxFit.contain);
                                    },
                                  ),
                                ),
                                title: Text(snapshot.data[index].name, style: TextStyle(fontSize: 25),),
                                subtitle: Text(snapshot.data[index].desc, style: TextStyle(fontSize: 20),),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Date: '+snapshot.data[index].date, style: TextStyle(fontSize: 15),),
                                  const SizedBox(width: 8),
                                  Visibility(
                                    visible: _orgaBool(snapshot.data[index].type),
                                    child: Text('Organisateur: '+snapshot.data[index].organisateur, style: TextStyle(fontSize: 15),)
                                  ),
                                  Visibility(visible: _orgaBool(snapshot.data[index].type), child: const SizedBox(width: 8),),
                                  Visibility(
                                      visible: _coursBool(snapshot.data[index].type),
                                      child: Text('Terrain: '+snapshot.data[index].terrain, style: TextStyle(fontSize: 15),)
                                  ),
                                  Visibility(visible: _coursBool(snapshot.data[index].type), child: const SizedBox(width: 8),),
                                  Visibility(
                                      visible: _coursBool(snapshot.data[index].type),
                                      child: Text('Discipline: '+snapshot.data[index].discipline, style: TextStyle(fontSize: 15),)
                                  ),
                                  Visibility(visible: _coursBool(snapshot.data[index].type), child: const SizedBox(width: 8),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('PARTICIPER'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('VALIDER'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
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
            )
          ]
        )
      )
    );
  }
}
