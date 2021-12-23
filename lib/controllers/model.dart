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
  String? tanggalShift;

  MTransaksi(
      {this.dt, this.supplier, this.jamIn, this.nettoRekon, this.tanggalShift});

  MTransaksi.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    supplier = json['supplier'];
    jamIn = json['jam_in'];
    nettoRekon = json['netto_rekon'];
    tanggalShift = json['tanggal_shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['supplier'] = this.supplier;
    data['jam_in'] = this.jamIn;
    data['netto_rekon'] = this.nettoRekon;
    data['tanggal_shift'] = this.tanggalShift;
    return data;
  }
}


