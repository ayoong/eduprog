// data model untuk merubah json ke dart class

class MUser {
  int? id;
  String? userName;
  String? userPassword;
  String? userFullName;
  String? lastRequest;
  String? userSession;

  MUser(
      {id,
      userName,
      userPassword,
      userFullName,
      lastRequest,
      userSession});

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
    data['id'] = id;
    data['user_name'] = userName;
    data['user_password'] = userPassword;
    data['user_full_name'] = userFullName;
    data['last_request'] = lastRequest;
    data['user_session'] = userSession;
    return data;
  }
}


class MTransaksi {
  String? dt;
  String? supplier;
  String? jamIn;
  int? nettoRekon;

  MTransaksi({dt, supplier, jamIn, nettoRekon});

  MTransaksi.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    supplier = json['supplier'];
    jamIn = json['jam_in'];
    nettoRekon = json['netto_rekon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = dt;
    data['supplier'] = supplier;
    data['jam_in'] = jamIn;
    data['netto_rekon'] = nettoRekon;
    return data;
  }
}

