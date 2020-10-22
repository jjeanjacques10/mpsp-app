enum ChatMessageType { sent, received }

class ChatMessage {
  int id;
  String botName;
  String type;
  String createdAt;
  int idUser;
  List<Messages> messages;

  ChatMessage(
      {this.id,
      this.botName,
      this.type,
      this.createdAt,
      this.idUser,
      this.messages});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    botName = json['bot_name'];
    type = json['type'];
    createdAt = json['createdAt'];
    idUser = json['id_user'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bot_name'] = this.botName;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['id_user'] = this.idUser;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String message;
  String ownerMessage;
  String createdAt;
  int idConversation;

  Messages(
      {this.message, this.ownerMessage, this.createdAt, this.idConversation});

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    ownerMessage = json['owner_message'];
    createdAt = json['created_at'];
    idConversation = json['id_conversation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['owner_message'] = this.ownerMessage;
    data['created_at'] = this.createdAt;
    data['id_conversation'] = this.idConversation;
    return data;
  }
}
