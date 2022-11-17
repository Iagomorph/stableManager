import 'dart:developer';
import 'eventClass.dart';

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

    print('connect appelé');
  }

  static addEvent(Event event) async {
    await eventCollection?.insertOne({
      'type':event.type,
      'name':event.name,
      'desc':event.desc,
      'date':event.date,
      'img':event.img,
      'terrain':event.terrain,
      'discipline':event.discipline,
      'organisateur':event.organisateur,
      'status':event.status,
    });

    print("addEvent appelé");
  }

  static getEvents() async{
    var events = await eventCollection?.find().toList();
    List eventsList = [];
    events?.forEach((item) {
      String type = item["type"];
      String name = item["name"];
      String desc = item["desc"];
      String date = item["date"];
      String img = item["img"];
      String terrain = item["terrain"];
      String discipline = item["discipline"];
      String organisateur = item["organisateur"];
      String status = item["status"];

      Event event = Event(type,name,desc,date,img,terrain,discipline,organisateur,status);

      eventsList.add(event);
    });

    print(eventsList);
    print(eventsList[0].name);
    return eventsList;
  }
}