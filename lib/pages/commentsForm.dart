import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stable_manager/obj/UserManager.dart';
import 'package:stable_manager/pages/evenementsForm.dart';
import '../mongodb.dart';
import '../obj/commentClass.dart';

class CommentsForm extends StatefulWidget{

  final String eventToken;

  static const tag = "commentsForm";
  const CommentsForm(this.eventToken, {super.key});
  @override
  State<CommentsForm> createState() => _NewComment(eventToken);
}
class _NewComment extends State<CommentsForm>{

  final String eventToken;
  _NewComment(this.eventToken);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nouveau commentaire"),
        ),
        body: FormNewComment(eventToken)
    );
  }
}

class FormNewComment extends StatefulWidget {

  final String eventToken;

  const FormNewComment(this.eventToken, {super.key});
  @override
  FormNewEvenementState createState() {
    return FormNewEvenementState(eventToken);
  }
}
class FormNewEvenementState extends State<FormNewComment> {
  final String eventToken;
  final _formKey = GlobalKey<FormState>();

  FormNewEvenementState(this.eventToken);

  final textController = TextEditingController();

  bool showCoursField = false;
  bool showOrgaField = true;

  String generateRandomToken(int len){
    var r = Random();
    String token = String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
    return token;
  }

  void _sendNewComment(){
    Comment comment = Comment(UserManager.user.name,eventToken,generateRandomToken(10),textController.text,);
    MongoDataBase.addComment(comment);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: <Widget>[
                SizedBox(height: 25.0,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Votre commentaire"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez écrire un commentaire.';
                    }
                    return null;
                  },
                  controller: textController,
                ),
                SizedBox(height: 25.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _sendNewComment();
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

