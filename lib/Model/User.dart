class UserModel {
  int id;
  String name;
  String localizacao;
  String cpf;
  String telefone;
  String email;
  String senha;

  UserModel({
    this.id,
    this.name,
    this.localizacao,
    this.cpf,
    this.telefone,
    this.email,
    this.senha,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizacao = json['localizacao'];
    cpf = json['cpf'];
    telefone = json['phone'];
    email = json['email'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['localizacao'] = this.localizacao;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['senha'] = this.senha;
    return data;
  }
}
