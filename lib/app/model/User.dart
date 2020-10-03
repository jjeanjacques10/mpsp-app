class UserModel {
  int id;
  String name;
  String cpf;
  String email;
  String password;
  String phone;
  String birthday;
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
    password = json['password'];
    phone = json['phone'];
    birthday = json['birthday'];
    isAdmin = json['is_admin'];
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
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['is_admin'] = this.isAdmin;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['password_hash'] = this.passwordHash;
    return data;
  }
}
