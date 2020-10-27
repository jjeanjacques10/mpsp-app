class UserModel {
  int id;
  String name;
  String cpf;
  String email;
  String password;
  String image;
  String location;
  String phone;
  DateTime birthday;
  bool isAdmin;
  String updatedAt;
  String createdAt;
  String passwordHash;

  UserModel(
      {this.id,
      this.name,
      this.cpf,
      this.email,
      this.password,
      this.image,
      this.location,
      this.phone,
      this.birthday,
      this.isAdmin,
      this.updatedAt,
      this.createdAt,
      this.passwordHash});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cpf = json['cpf'];
    email = json['email'];
    password = json.containsKey('password') ? json['password'] : '';
    image = json['image'] != null ? json['image'] : '';
    location = json['location'] != null ? json['location'] : '';
    phone = json['phone'];
    birthday =
        json['birthday'] != null ? DateTime.parse(json['birthday']) : null;
    isAdmin = json['is_admin'] ? true : false;
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    passwordHash = json['password_hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['birthday'] =
        "${this.birthday.year.toString()}-${this.birthday.month.toString().padLeft(2, '0')}-${this.birthday.day.toString().padLeft(2, '0')}";
    data['is_admin'] = this.isAdmin;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['password_hash'] = this.passwordHash;
    return data;
  }
}
