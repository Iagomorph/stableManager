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
    var usersJson = await collection?.find().toList();
    print(usersJson);
    List<User> users = [];
    User user = User("","","","","",false,"");
    usersJson?.forEach((e){
      users.add(user.toJson(e));
    });
    return users;
  }

  static getUserByToken(token) async {
    var user = await collection?.findOne(
      where.eq("token", token));
    return user;
  }
}