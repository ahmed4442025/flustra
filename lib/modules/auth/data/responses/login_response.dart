class LoginResponse {
  bool? status;
  String? message;
  UserDataResponse? data;
  int? code;

  LoginResponse({this.status, this.message, this.data, this.code});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataResponse.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class UserDataResponse {
  UserResponse? user;
  String? token;

  UserDataResponse({this.user, this.token});

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserResponse {
  int? id;
  String? name;
  String? email;

  UserResponse({this.id, this.name, this.email});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
