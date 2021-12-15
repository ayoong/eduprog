// data model untuk merubah json ke dart class

class MUser {
  int? id;
  String? userName;
  String? userPassword;
  String? userFullName;
  String? lastRequest;
  String? userSession;

  MUser(
      {this.id,
      this.userName,
      this.userPassword,
      this.userFullName,
      this.lastRequest,
      this.userSession});

  MUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userPassword = json['user_password'];
    userFullName = json['user_full_name'];
    lastRequest = json['last_request'];
    userSession = json['user_session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_password'] = this.userPassword;
    data['user_full_name'] = this.userFullName;
    data['last_request'] = this.lastRequest;
    data['user_session'] = this.userSession;
    return data;
  }
}
