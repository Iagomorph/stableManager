import 'dart:developer';
import 'package:stable_manager/obj/UserManager.dart';

import 'obj/eventClass.dart';
import 'obj/commentClass.dart';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';
import 'obj/Horse.dart';
import 'obj/User.dart';
import 'obj/logClass.dart';


class MongoDataBase {
  static DbCollection? collection;
  static DbCollection? eventCollection;
  static DbCollection? horseCollection;
  static DbCollection? commentCollection;
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
    commentCollection = db.collection(COMMENT_COLLECTION_NAME);
    logCollection = db.collection(LOG_COLLECTION);
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
      'duree':event.duree,
      'adresse':event.adresse,
      'token':event.token
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

  await horseCollection?.update(where.eq('userId',uToken).and(where.eq('name',horse.nom)),
  modify.set("DpUser", DpToken),
  );
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
      String duree = item["duree"];
      String adresse = item["adresse"];
      String token = item["token"];

      Event event = Event(type,name,desc,date,img,terrain,discipline,organisateur,status,participants,commentaires,duree,adresse,token);

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

  static addComment(comment) async {
    await commentCollection?.insertOne({
      'eventToken': comment.eventToken,
      'username': comment.username,
      'commentToken': comment.commentToken,
      'message': comment.message
    });

    print("addComment appelé.");
    print(comment.username);
    print(comment.eventToken);
    print(comment.message);
    print(comment.commentToken);
  }
  static getComments(eventToken) async {
    var comments = await commentCollection?.find(
        where.eq('eventToken', eventToken)).toList();
    List commentsList = [];
    comments?.forEach((item) {
      String eventToken = item["eventToken"];
      String username = item["username"];
      String commentToken = item["commentToken"];
      String message = item["message"];

      Comment comment = Comment(username, eventToken, commentToken, message);

      commentsList.add(comment);
    });

    print('Commentaires vvv');
    print(commentsList);
    print(commentsList[0].username);
    return commentsList;
  }

  //créer un form userUpdate et horse update avec une méthode updateUser/Horse qui prend tout les champs
  //surtout les "Aucun" et replace ces fields avec les values des user/horse passer
  //add le bouton sur les chevaux et le bouton modif profil
  static updateUser(User user) async {
    await collection?.updateOne(where.eq('token',user.token),({'name':user.name, 'mail':user.mail,'type':user.type,'ffe':user.ffe,'age':user.age, 'tel':user.tel }));
  }

  static updateHorse(Horse horse, User user) async {
    await horseCollection?.update(where.eq('userId',user.token), ({'photo':horse.image,'name':horse.nom,'age':horse.age,'robe':horse.robe,'race':horse.race,'sexe':horse.sexe,'spec':horse.spec,"userId":horse.userId,"DpUser":horse.DpUser}));
  }

  static addLog(Logs logs) async {
    await logCollection?.insertOne({
      'type': logs.type,
      'user': logs.user,
      'event': logs.event,
    });
    print("addLog appelé");
  }

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
}

