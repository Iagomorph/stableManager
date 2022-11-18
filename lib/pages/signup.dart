import 'package:flutter/material.dart';
import 'package:stable_manager/mongodb.dart';
import 'package:stable_manager/obj/User.dart';

class Signup extends StatefulWidget {
  static const tag = "signup";

  const Signup({super.key});
  @override
  State<StatefulWidget> createState() => _MySignupState();
}

class _MySignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String _dropDownValue = "DP";

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final pwdController = TextEditingController();
  final imageController = TextEditingController();
  final typeController = TextEditingController();

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
          //formulaire d'inscription
          key: _formKey,
          child: Column(
            children: [
              //field Username
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                controller: nameController,
              ),

              //field Mail
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid mail';
                  }
                  return null;
                },
                controller: mailController,
              ),

              //field Password
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                controller: pwdController,
              ),

              //field Image Url
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'image url',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image url for your profile';
                  }
                  return null;
                },
                controller: imageController,
              ),

              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(
                    child: Text("Demi-pensionnaire"),
                    value: "DP",
                  ),
                  DropdownMenuItem(
                    child: Text("Propriétaire"),
                    value: "Propriétaire",
                  )
                ],
                onChanged: dropdownCallback,
                value: _dropDownValue,
              ),

              //Submit Button
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String mail = mailController.text;
                  String pwd = pwdController.text;
                  String img = imageController.text;
                  String token = generateRandomToken(10);
                  String type = _dropDownValue;

                  User user = User(name, mail, pwd, img, token, false, type);
                  await MongoDataBase.addUser(user);

                  Navigator.pop(context, user);
                },
                child: const Text("Sign Up"),
              ),
            ],
          )),
    );
  }
}
