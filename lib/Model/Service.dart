class UserModel {
  int id;
  String nameServise;
  String dateService;
  String attendant;

  UserModel({
    this.id,
    this.nameServise,
    this.dateService,
    this.attendant,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameServise = json['nameServise'];
    dateService = json['dateService'];
    attendant = json['attendant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameServise'] = this.nameServise;
    data['dateService'] = this.dateService;
    data['attendant'] = this.attendant;
    return data;
  }
}
