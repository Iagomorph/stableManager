import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.grey),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, color: Colors.black),
              const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              const Text('Username', style: TextStyle(color: Colors.black, fontSize: 18)),
            ],
          )),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                ),
                child: const Text("Actu"),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: const Text("Cours"),
              ),
            ],
          ),
          const Divider(
            thickness: 5,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  // width: 200,
                  color: Colors.deepPurple[300],
                )
            ),
          ),
        ],
      ),
    );
  }
}