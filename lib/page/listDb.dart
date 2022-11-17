import 'package:flutter/material.dart';
import '../model/user.dart';
import '../database/mongodb.dart';
import '../model/cheval.dart';

class ListDbView extends StatefulWidget {
  const ListDbView({Key? key}) : super(key: key);

  @override
  _ListDbViewState createState() => _ListDbViewState();
}

class _ListDbViewState extends State<ListDbView> {

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              // future: MongoDatabase.getUsers(),
              future: MongoDatabase.getCheval(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  if(snapshot.hasData){
                    var totalData = snapshot.data.length;
                    print("Total data$totalData");
                    return ListView.builder(
                        itemCount:snapshot.data.length,
                        itemBuilder: (context, index){
                          return displayCard(
                              // User.fromJson(snapshot.data[index]));
                              Cheval.fromJson(snapshot.data[index]));
                        }
                        );
                  }else{
                    return const Center(
                      child: Text("no data avalaible"),
                    );
                  }
                }
              },
            ),
          ),
        )
    );
  // Widget displayCard(User data) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         children: [
  //           Text("${data.id}"),
  //           const SizedBox(height: 5,),
  //           Text(data.name),
  //           const SizedBox(height: 5,),
  //           Text(data.mail),
  //           const SizedBox(height: 5,),
  //           Text("${data.age}"),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget displayCard(Cheval data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("${data.id}"),
            const SizedBox(height: 5,),
            Text(data.photo),
            const SizedBox(height: 5,),
            Text(data.name),
            const SizedBox(height: 5,),
            Text("${data.age}"),
          ],
        ),
      ),
    );
  }
}