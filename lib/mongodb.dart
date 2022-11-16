import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';

class MongoDataBase {
  static DbCollection? collection;
  static DbCollection? eventCollection;

  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    collection = db.collection(COLLECTION_NAME);
    eventCollection = db.collection(EVENT_COLLECTION_NAME);
    print(await collection?.find().toList());

    await eventCollection?.insertOne({
      'type':'soiree',
      'name':'bal',
      'desc':'dansant',
      'date':'10010101',
      'img':'img',
      'terrain':'',
      'discipline':'',
      'organisateur':'léo',
      'status':'pending'
    });

    print('hello');
  }

  static addEvent(type,name,desc,date,img,terrain,discipline,organisateur) async {
    await eventCollection?.insertOne({
      'type':type,
      'name':name,
      'desc':desc,
      'date':date,
      'img':img,
      'terrain':terrain,
      'discipline':discipline,
      'organisateur':organisateur
    });

    print("addEvent appelé.");
  }
}