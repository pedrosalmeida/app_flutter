class Usuario {
  int? messageType;
  String? messageTypeDescription;
  String? message;
  String? responseDateTime;
  Registers? registers;

  Usuario(
      {this.messageType,
      this.messageTypeDescription,
      this.message,
      this.responseDateTime,
      this.registers});

  Usuario.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    messageTypeDescription = json['messageTypeDescription'];
    message = json['message'];
    responseDateTime = json['responseDateTime'];
    registers = json['registers'] != null
        ? new Registers.fromJson(json['registers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageType'] = this.messageType;
    data['messageTypeDescription'] = this.messageTypeDescription;
    data['message'] = this.message;
    data['responseDateTime'] = this.responseDateTime;
    if (this.registers != null) {
      data['registers'] = this.registers!.toJson();
    }
    return data;
  }

  getToken() {}
}

class Registers {
  int? id;
  int? managerId;
  Null? name;
  Null? username;
  Null? password;
  int? role;
  Null? roleName;
  String? token;

  Registers(
      {this.id,
      this.managerId,
      this.name,
      this.username,
      this.password,
      this.role,
      this.roleName,
      this.token});

  Registers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managerId = json['managerId'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    roleName = json['roleName'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['managerId'] = this.managerId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['roleName'] = this.roleName;
    data['token'] = this.token;
    return data;
  }

  String toString() {
    return 'Usuario(token: $token)';
  }
}
