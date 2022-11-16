import 'package:flutter/material.dart';
import 'package:stable_manager/main.dart';

import 'package:stable_manager/mongodb.dart';
import '../main.dart';

import '../obj/User.dart';
import 'signup.dart';


class Login extends StatefulWidget {
  static const tag = "login";


  const Login({super.key});
  @override
  State<StatefulWidget> createState() => _MyLoginState();


}

class _MyLoginState extends State<Login>{

  List<User> Users = [];
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final pwdController = TextEditingController();

  void getUsers() async {
    Users = await MongoDataBase.getUsers();
  }

  @override
  void initState(){
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            title: Text("Sign in"),
          ),

          body:
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField( decoration:
                  const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:'username',
                ),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                controller: nameController,
              ),

                TextFormField( decoration:
                const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:'password',
                ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  controller: pwdController,
                ),


                ElevatedButton(onPressed:(){

                  String name = nameController.text;
                  String pwd = pwdController.text;

                  Users.forEach((user) {
                    if (user.name == name && user.password == pwd){
                      print("kekl");
                      User loggedUser = user;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Marie Ecurie',)));
                    }
                  });
                },
                  child: const Text("Connectez-vous"),
                ),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                }, child: const Text('Inscrivez-vous'))
              ],
            ),
          ),
        );
  }


}