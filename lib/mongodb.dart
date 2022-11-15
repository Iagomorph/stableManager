import 'dart:developer';
import 'dart:js_util';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';


class MongoDataBase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    print(await collection?.find().toList());
  }
}