// To parse this JSON data, do
//
//     final cavalier = cavalierFromMap(jsonString);
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Cheval {
  Cheval({
    required this.id,
    required this.photo,
    required this.name,
    required this.age,
  });

  ObjectId id;
  String photo;
  String name;
  int age;

  factory Cheval.fromJson(Map<String, dynamic> json) {
    return Cheval(
        id: json['_id'],
        photo: json["photo"],
        name: json["name"],
        age: json["age"]
    );
  }
}

