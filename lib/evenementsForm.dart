import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'mongodb.dart';
import 'eventClass.dart';

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

  String _eventType = '';

  bool showForm = false;
  bool showCoursField = false;
  bool showImgField = false;
  bool showOrgaField = false;

  void _sendNewEvent(){
    Event event = Event(_eventType,nomController.text,descController.text,dateController.text,imgController.text,terrainController.text,disciplineController.text,orgaController.text,'pending');
    MongoDataBase.addEvent(event);
  }

  @override
  void initState() {
    super.initState();
    _eventType = '';
  }

  void checkFieldVisibility(){
    if(_eventType == "soiree"){
      showForm = true;
      showOrgaField = true;
      showImgField = true;
      showCoursField = false;
    }else if(_eventType == "competition"){
      showForm = true;
      showImgField = true;
      showCoursField = false;
      showOrgaField = false;
    }else if(_eventType == "cours"){
      showForm = true;
      showCoursField = true;
      showOrgaField = false;
      showImgField = false;
    };
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DropDownButtonFormField(
          //   titleText: "Type d'évènement",
          //   hintText: 'Veuillez choisir un type',
          //   value: _eventType,
          //   onSaved: (value) {
          //     setState(() {
          //       _eventTypeResult = value;
          //     });
          //   },
          //   onChanged: (value) {
          //     setState(() {
          //       _eventType = value;
          //       checkFieldVisibility();
          //     });
          //   },
          //   dataSource: const [
          //     {
          //       "display": "Soirée",
          //       "value": "soiree",
          //     },
          //     {
          //       "display": "Cours",
          //       "value": "cours",
          //     },
          //     {
          //       "display": "Compétition",
          //       "value": "competition",
          //     },
          //   ],
          //   textField: 'display',
          //   valueField: 'value',
          //   validator: (value) {
          //     if (value == '') {
          //       return 'Please select an option';
          //     }
          //     return null;
          //   },
          // ),
          SizedBox(height: 25.0),
          Visibility(visible: showForm,
              child: Column(
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
                  Visibility(
                    visible: showImgField,
                    child: TextFormField(
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
                  ),
                  Visibility(visible: showImgField, child: SizedBox(height: 25.0,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          _sendNewEvent();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ]
            )
          ),
        ],
      ),
    );
  }
}

