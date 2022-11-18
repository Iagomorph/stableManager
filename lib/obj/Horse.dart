
import 'dart:core';

class Horse {
  String userId;
  String image;
  String nom;
  int age;
  String robe;
  String race;
  String sexe;
  String spec;
  String DpUser ;

  Horse(this.userId,this.image, this.nom, this.age, this.robe, this.race, this.sexe, this.spec, [this.DpUser = "Aucun"]);

  fromJson(Map<String, dynamic> json){
    return Horse(json['owner'],json['photo'],json['name'],json['age'],json['robe'],json['race'],json['sexe'],json['spec']);
  }
}