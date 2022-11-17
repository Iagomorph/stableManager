import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

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
              children: const [
                Icon(Icons.person, color: Colors.black),
                Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
                Text('Username', style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (_, index)=>Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridTile(
                  header: const GridTileBar(
                    backgroundColor: Colors.blueGrey,
                    leading: Icon(Icons.person),
                    title: Text('cavalier'),
                    trailing: Icon(
                      Icons.menu,
                    ),
                  ),
                  footer: const GridTileBar(
                    backgroundColor: Colors.blueGrey,
                    leading: Icon(Icons.delete),
                  ),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2017/11/22/16/04/pug-2970825__480.png",
                    fit: BoxFit.cover,
                  )
              ),
            ),
            itemCount: 10,
          ),
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}