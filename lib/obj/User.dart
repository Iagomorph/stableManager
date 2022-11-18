import 'dart:math';

String generateRandomToken(int len) {
  var r = Random();
  String token =
      String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  return token;
}

class User {
  String name;
  String mail;
  String password;
  String picture;
  String token;
  bool isOwner = false;
  String type;
  String ffe;

  String age;

  String tel;

  User(this.name, this.mail, this.password, this.picture, this.token,
      this.isOwner, this.type,
      [this.ffe = "Aucun", this.age = "Aucun", this.tel = "Aucun"]);

  fromJson(Map<String, dynamic> json) {
    print(json);
    return User(json['name'], json['mail'], json['password'], json['picture'],
        json['token'], json['isOwner'], json['type']);
  }
}
