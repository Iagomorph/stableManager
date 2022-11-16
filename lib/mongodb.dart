import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';
import 'obj/User.dart';


class MongoDataBase {
  static DbCollection? collection;

  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
  }

  static addUser(User user) async {
    await collection?.insertOne({
      'name' : user.name,
      'mail' : user.mail,
      'password' : user.password,
      'image' : user.picture,
      'token': user.token,
      'isOwner': user.isOwner,
      "type" : user.type,
    });
  }

  static getUsers() async {
    //liste des bails en bdd format json
    var users = await collection?.find().toList();
    //liste vide
    List<User> usersList = [];
    //on fait un forEach dans la liste json
    users?.forEach((item) {
      //on extrait les éléments du json dans des variables
      String name = item["name"];
      String mail = item["mail"];
      String pwd = item["password"];
      String img = item["image"];
      String token = item["token"];
      bool isOwner = item["isOwner"];
      String type = item["type"];
      //on crée un objet à partir des variables extraites du json
      final user = User(name,mail,pwd,img,token,isOwner,type);
      //on ajoute l'objet à la liste vide
      usersList.add(user);
      }
    );
    //on retourne la liste
    return usersList;
  }



  static getUserByToken(token) async {
    var user = await collection?.findOne(
      where.eq("token", token));
    return user;
  }
}