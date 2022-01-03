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
      {dt, supplier, jamIn, nettoRekon, tanggalShift});

  MTransaksi.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    supplier = json['supplier'];
    jamIn = json['jam_in'];
    nettoRekon = json['netto_rekon'];
    tanggalShift = json['tanggal_shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = dt;
    data['supplier'] = supplier;
    data['jam_in'] = jamIn;
    data['netto_rekon'] = nettoRekon;
    data['tanggal_shift'] = tanggalShift;
    return data;
  }
}

class MTablePerBulan {
  String? tanggal;
  int? rit;
  int? tonase;

  MTablePerBulan({tanggal, rit, tonase});

  MTablePerBulan.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    rit = json['rit'];
    tonase = json['tonase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = tanggal;
    data['rit'] = rit;
    data['tonase'] = tonase;
    return data;
  }
}



