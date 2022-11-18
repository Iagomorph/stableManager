class Event {
  String type = '';
  String name = '';
  String desc = '';
  String date = '';
  String img = '';
  String terrain = '';
  String discipline = '';
  String organisateur = '';
  String status = '';
  List participants;
  List commentaires;
  String duree = '';
  String token = '';

  Event(
    this.type,
    this.name,
    this.desc,
    this.date,
    this.img,
    this.terrain,
    this.discipline,
    this.organisateur,
    this.status,
    this.participants,
    this.commentaires,
    this.duree,
    this.token
  );
}