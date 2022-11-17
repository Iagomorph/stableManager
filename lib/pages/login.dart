import 'package:flutter/material.dart';
import 'package:stable_manager/main.dart';

import 'package:stable_manager/mongodb.dart';
import 'package:stable_manager/obj/UserManager.dart';
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

  final resetPwdController = TextEditingController();
  final resetUsernameController = TextEditingController();
  final resetMailController = TextEditingController();

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

                //bouton Login
                ElevatedButton(onPressed:(){

                  String name = nameController.text;
                  String pwd = pwdController.text;

                  Users.forEach((user) {
                    if (user.name == name && user.password == pwd){
                      print("kekl");
                      User loggedUser = user;
                      //UserManager.user stock les infos de l'utilisateur connecté
                      //si le login est ok
                      UserManager.user = loggedUser;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Marie Ecurie',)));
                    }
                  });
                },
                  child: const Text("Connectez-vous"),
                ),

                //bouton redirect signup
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                }, child: const Text('Inscrivez-vous')),

                //bouton reset mdp
                ElevatedButton(onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      content: Form(child: Column(
                        children: [

                          Text("Nom d'utilisateur : "),

                        TextFormField( decoration:
                        const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:"nom d'utilisateur",
                          hintText: "Entrez votre nom d'utilisateur "
                        ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Entrez votre nom d'utilisateur";
                            }
                            return null;
                          },
                          controller: resetUsernameController,
                        ),

                          Text(" Adresse Mail : "),

                          TextFormField( decoration:
                          const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'mail',
                            hintText:"Entrez votre mail"
                          ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'entrez un mail valide';
                              }
                              return null;
                            },
                            controller: resetMailController,
                          ),

                          Text("Nouveau mot de passe :"),

                          TextFormField( decoration:
                          const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'mot de passe',
                            hintText: "Rentrez votre nouveau mot de passe"
                          ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                            controller: resetPwdController,
                          ),

                          ElevatedButton(onPressed: (){
                            var username = resetUsernameController.text;
                            var mail = resetMailController.text;
                            var newPwd = resetPwdController.text;
                          Users.forEach((user) async {
                          if (user.name == username && user.mail == mail){
                            await MongoDataBase.updateUserPassword(user, newPwd);
                            UserManager.user = user;
                            Navigator.pop(context);
                          } else {
                          }
                          });
                          }, child: Text("Changer le mot de passe"))
                      ]),


                      )
                    );
                  });
                }, child: const Text('Mot de passe oublié ?'))
              ],
            ),
          ),
        );
  }


}