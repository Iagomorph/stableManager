import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';
import 'obj/Horse.dart';
import 'eventClass.dart';
import 'logClass.dart';
import 'obj/User.dart';

class MongoDataBase {
  static DbCollection? collection;
  static DbCollection? eventCollection;
  static DbCollection? horseCollection;

  static DbCollection? logCollection;

  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    inspect(db);
    var status = db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
    eventCollection = db.collection(EVENT_COLLECTION_NAME);
    horseCollection = db.collection(HORSE_COLLECTION);
    logCollection = db.collection(LOG_COLLECTION_NAME);
    print('connect appelé');
  }

  static addUser(User user) async {
    await collection?.insertOne({
      'name': user.name,
      'mail': user.mail,
      'password': user.password,
      'image': user.picture,
      'token': user.token,
      'isOwner': user.isOwner,
      "type": user.type,
      "ffe": user.ffe,
      "age": user.age,
      "tel": user.tel,
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
      // if(item['ffe'] != "Aucun" && item['age'] != "Aucun" && item['tel'] != "Aucun"){
        String ffe = item['ffe'];
        String age = item['age'];
        String tel = item['tel'];

        final user = User(
            name,
            mail,
            pwd,
            img,
            token,
            isOwner,
            type,
            ffe,
            age,
            tel);

        usersList.add(user);

      // }
      // final user = User(
      //     name,
      //     mail,
      //     pwd,
      //     img,
      //     token,
      //     isOwner,
      //     type);
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

  static updateUserPassword(User user, String password) async {
    var username = user.name;
    var mail = user.mail;
    await collection?.update(
        where.eq('name', username).and(where.eq('mail', mail)),
        modify.set('password', password));
  }


  static addEvent(type, name, desc, date, img, terrain, discipline,
      organisateur) async {
    await eventCollection?.insertOne({
      'type': type,
      'name': name,
      'desc': desc,
      'date': date,
      'img': img,
      'terrain': terrain,
      'discipline': discipline,
      'organisateur': organisateur
    });

    print("addEvent appelé.");
  }


  static addHorse(Horse horse) async {
    await horseCollection?.insertOne({
      "owner": horse.userId,
      "photo": horse.image,
      'name': horse.nom,
      "age": horse.age,
      "robe": horse.robe,
      "race": horse.race,
      "sexe": horse.sexe,
      "spec": horse.spec,
      "DpUser" : horse.DpUser,
    });
  }

  static getHorses() async {
    var horses = await horseCollection?.find().toList();

    List<Horse> horsesList = [];

    horses?.forEach((item) {
      String userid = item['userId'];
      String img = item['photo'];
      String name = item['name'];
      int age = item['age'];
      String robe = item['robe'];
      String race = item['race'];
      String sexe = item['sexe'];
      String spec = item['spec'];
      String DpUser = item['DpUser'];
        final horse = Horse(
            userid,
            img,
            name,
            age,
            robe,
            race,
            sexe,
            spec,
            DpUser);
        horsesList.add(horse);
    });
    return horsesList;
  }

  static getUserHorses(token) async {
    // var user = getUserByToken(token);

    List<Horse> horseList = [];
    var userHorseList = await horseCollection?.find(
        where.eq("userId", token)
    ).toList();

    userHorseList?.forEach((item) {
      String owner = item['userId'];
      String img = item['photo'];
      String name = item['name'];
      int age = item['age'];
      String robe = item['robe'];
      String race = item['race'];
      String sexe = item['sexe'];
      String spec = item['spec'];
      String DpUser = item['DpUser'];

      final horse = Horse(
          owner,
          img,
          name,
          age,
          robe,
          race,
          sexe,
          spec,
      DpUser);

      horseList.add(horse);
    });

    return horseList;
  }

  static getUserDpHorses(token) async {
    List<Horse> horseList = [];
    var userHorseList = await horseCollection?.find(
        where.eq("DpUser", token)
    ).toList();

    userHorseList?.forEach((item) {
      String owner = item['userId'];
      String img = item['photo'];
      String name = item['name'];
      int age = item['age'];
      String robe = item['robe'];
      String race = item['race'];
      String sexe = item['sexe'];
      String spec = item['spec'];
      String DpUser = item['DpUser'];

      final horse = Horse(
          owner,
          img,
          name,
          age,
          robe,
          race,
          sexe,
          spec,
      DpUser);

      horseList.add(horse);
    });

    return horseList;
  }

  static updateHorseDp(Horse horse, String uToken, String DpToken) async {

  await horseCollection?.update(where.eq('owner',uToken).and(where.eq('name',horse.nom)),
  modify.set("DpUser", DpToken),
  );
  }

  //créer un form userUpdate et horse update avec une méthode updateUser/Horse qui prend tout les champs
  //surtout les "Aucun" et replace ces fields avec les values des user/horse passer
  //add le bouton sur les chevaux et le bouton modif profil
  static updateUser(User user) async {
    await collection?.updateOne(where.eq('token',user.token),({'name':user.name, 'mail':user.mail,'type':user.type,'ffe':user.ffe,'age':user.age, 'tel':user.tel }));
  }

  // {
  // "type":"", // newEvent, newUser, eventValidated, eventRefused
  // "user": {},
  // "eve": {},
  // }

  static getLog() async {
    var logs = await logCollection?.find().toList();
    List logsList = [];
    logs?.forEach((item) {
      String type = item["type"];
      String user = item["user"];
      String event = item["event"];
      final log = Logs(type, user, event);
      logsList.add(log);
    });
    return logsList;
  }

  static addLog(Logs logs) async {
    await logCollection?.insertOne({
      'type': logs.type,
      'user' : logs.user,
      'event' : logs.event,
    });
    print("addLog appelé");
  }
}