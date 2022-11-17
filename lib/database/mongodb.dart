import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import '../model/user.dart';
import 'constant.dart';

class MongoDatabase {
  static var db, usercollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    usercollection = db.collection(COLLECTION_USER);

  }

  static Future<List<Map<String,dynamic>>> getUsers() async {
    final arrData = await usercollection.find().toList();
    return arrData;
  }

  // static Future<String> insert(Cavalier data) async {
  //   try {
  //     var result = await cavalierCollection.insertOne(data.toJson());
  //     if(result.isSuccess){
  //       return "Successes Data Inserted";
  //     }
  //     else {
  //       return "Failed Data not Inserted";
  //     }
  //   } catch(e){
  //     print(e.toString());
  //     return e.toString();
  //   }
  // }
}