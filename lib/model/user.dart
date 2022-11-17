import 'package:mongo_dart/mongo_dart.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.mail,
    required this.image,
    required this.type,
  });

  ObjectId id;
  String name;
  String mail;
  String image;
  String type;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        mail: json['mail'],
        image: json['image'],
        type: json['type'],
    );
  }
}