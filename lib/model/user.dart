import 'package:mongo_dart/mongo_dart.dart';

import 'cheval.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.mail,
    required this.age,
    // required this.cheval,
  });

  ObjectId id;
  String name;
  String mail;
  int age;
  // List<Cheval> cheval;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        mail: json['mail'],
        age: json['age'],
        // cheval: List<Cheval>.from(json["cheval"])
    );
  }
}