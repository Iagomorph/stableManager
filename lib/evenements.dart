import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stable_manager/evenementsForm.dart';
import 'mongodb.dart';

class Evenements extends StatefulWidget{
  static const tag = "evenements";

  const Evenements({super.key});
  @override
  State<Evenements> createState() => _AllEvenements();

}

class _AllEvenements extends State<Evenements>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evenements"),
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

    );
  }
}