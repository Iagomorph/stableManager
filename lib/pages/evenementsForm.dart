import 'dart:math';
import 'package:flutter/material.dart';
import '../mongodb.dart';
import '../obj/eventClass.dart';
import '../obj/logClass.dart';

class EvenementsForm extends StatefulWidget{
  static const tag = "evenementsform";
  const EvenementsForm({super.key});
  @override
  State<EvenementsForm> createState() => _NewEvenement();
}
class _NewEvenement extends State<EvenementsForm>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvel évènement"),
      ),
      body: FormNewEvenement()
    );
  }
}

class FormNewEvenement extends StatefulWidget {
  const FormNewEvenement({super.key});
  @override
  FormNewEvenementState createState() {
    return FormNewEvenementState();
  }
}
class FormNewEvenementState extends State<FormNewEvenement> {
  final _formKey = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final descController = TextEditingController();
  final typeController = TextEditingController();
  final dateController = TextEditingController();

  final imgController = TextEditingController();
  final terrainController = TextEditingController();
  final disciplineController = TextEditingController();
  final orgaController = TextEditingController();
  final dureeController = TextEditingController();
  final adresseController = TextEditingController();

  String _eventType = "soiree";

  bool showCoursField = false;
  bool showOrgaField = true;
  bool showCompField = false;

  String generateRandomToken(int len){
    var r = Random();
    String token = String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
    return token;
  }

  void _sendNewEvent(){
    Event event = Event(_eventType,nomController.text,descController.text,dateController.text,imgController.text,terrainController.text,disciplineController.text,orgaController.text,'pending',[],[],dureeController.text,adresseController.text,generateRandomToken(10));
    MongoDataBase.addEvent(event);
  }

  void _sendNewLog() {
    Logs logs = Logs('Last ' + _eventType, '', nomController.text);
    MongoDataBase.addLog(logs);
  }

  @override
  void initState() {
    super.initState();
    _eventType = '';
  }

  void checkFieldVisibility(eventType){
    if(eventType == "soiree"){
      showOrgaField = true;
      showCoursField = false;
      showCompField = false;
    }else if(eventType == "comp"){
      showCompField = true;
      showCoursField = false;
      showOrgaField = false;
    }else if(eventType == "cours"){
      showCoursField = true;
      showCompField = false;
      showOrgaField = false;
    };
    _eventType = eventType;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
            items: const[
              DropdownMenuItem(child: Text("Soirée"), value: "soiree",),
              DropdownMenuItem(child: Text("Cours"), value: "cours",),
              DropdownMenuItem(child: Text("Compétition"), value: "comp",)
            ],
            value: "soiree",
            onChanged: (value) { setState(() {
              checkFieldVisibility(value);
            }); ;},
            hint: const Text("Choisissez un type d'évènement"),
            validator: (value) {
              if (value == '') {
                return 'Veuillez choisir une option';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Titre de l'évènement"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom valide.';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                SizedBox(height: 25.0,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description de l'évènement"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description.';
                    }
                    return null;
                  },
                  controller: descController,
                ),
                SizedBox(height: 25.0,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Date de l'évènement"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une date valide.';
                    }
                    return null;
                  },
                  controller: dateController,
                ),
                const SizedBox(height: 25.0,),
                Visibility(
                  visible: showCoursField,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Terrain du cours"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un terrain.';
                      }
                      return null;
                    },
                    controller: terrainController,
                  ),
                ),
                Visibility(visible: showCoursField, child: SizedBox(height: 25.0,)),
                Visibility(
                  visible: showCoursField,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Discipline du cours"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une discipline.';
                      }
                      return null;
                    },
                    controller: disciplineController,
                  ),
                ),
                Visibility(visible: showCoursField, child: SizedBox(height: 25.0,)),
                Visibility(
                  visible: showCoursField,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Duree"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une duree de cours.';
                      }
                      return null;
                    },
                    controller: dureeController,
                  ),
                ),
                Visibility(visible: showCoursField, child: SizedBox(height: 25.0,)),
                Visibility(
                  visible: showCompField,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adresse de la compétition"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une adresse.';
                      }
                      return null;
                    },
                    controller: adresseController,
                  ),
                ),
                Visibility(visible: showCompField, child: SizedBox(height: 25.0,)),
                Visibility(
                  visible: showOrgaField,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Organisateur de la soirée"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom valide.';
                      }
                      return null;
                    },
                    controller: orgaController,
                  ),
                ),
                Visibility(visible: showOrgaField, child: SizedBox(height: 25.0,)),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Illustration du post de l'évènement"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un lien valide.';
                    }
                    return null;
                  },
                  controller: imgController,
                ),
                SizedBox(height: 25.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _sendNewEvent();
                        _sendNewLog();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }
}

