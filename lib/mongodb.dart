import 'dart:developer';
import 'package:stable_manager/obj/UserManager.dart';

import 'obj/eventClass.dart';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';
import 'obj/User.dart';

class MongoDataBase {
  static DbCollection? collection;
  static DbCollection? eventCollection;

  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    inspect(db);
    var status = db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
    eventCollection = db.collection(EVENT_COLLECTION_NAME);
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

  static updateUserPassword(User user, String password) async{
    var username = user.name;
    var mail = user.mail;
    await collection?.update(where.eq('name',username).and(where.eq('mail', mail)),
        modify.set('password', password));
    }

  static addEvent(event) async {
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
      'participants':[UserManager.user.token],
      'commentaires':[],
      'token':event.token
    });

    print("addEvent appelé.");

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
      List participants = item["participants"];
      List commentaires = item["commentaires"];
      String token = item["token"];

      Event event = Event(type,name,desc,date,img,terrain,discipline,organisateur,status,participants,commentaires,token);

      eventsList.add(event);
    });

    print(eventsList);
    print(eventsList[0].name);
    return eventsList;
  }

  static updateEventStatus(token, status) async{
    await eventCollection?.updateOne(where.eq('token', token), modify.set('status', status));
  }

  static addEventParticipant(eventToken, userToken) async{
    await eventCollection?.updateOne(where.eq('token', eventToken), modify.addToSet('participants', userToken));
  }
  static removeEventParticipant(eventToken, userToken) async{
    await eventCollection?.updateOne(where.eq('token', eventToken).and(where.eq('participants', userToken)), modify.pull('participants', userToken));
  }
  static getAllParticipants(eventToken, userToken) async{
    var collec = await eventCollection?.find(where.eq('token', eventToken)).toList();
    return(collec?[0]['participants']);
  }
}