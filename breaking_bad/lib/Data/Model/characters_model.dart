class CharactersModel {
  int charID;
  String birthday;
  String name;
  List<dynamic> occupation;
  String image;
  String status;
  List<dynamic> appearance;
  String nickname;
  String portrayed;
  List<dynamic> betterCallSaulAppearance;
  String categoryForTwoSeries;

  CharactersModel.fromJson(Map<String, dynamic> json) {
    charID = json['char_id'];
    birthday = json['birthday'];
    name = json['name'];
    occupation = json['occupation'];
    image = json['img'];
    status = json['status'];
    appearance = json['appearance'];
    nickname = json['nickname'];
    portrayed = json['portrayed'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
    categoryForTwoSeries = json["category"];
  }
}
