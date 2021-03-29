class ResponseTokenBody {
  String refresh;
  String access;
  int accessExpires;
  int refreshExpires;
  int userId;
  UserData userData;

  ResponseTokenBody({this.refresh, this.access, this.accessExpires, this.refreshExpires, this.userId, this.userData});

  ResponseTokenBody.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    accessExpires = json['access_expires'];
    refreshExpires = json['refresh_expires'];
    userId = json['user_id'];
    userData = json['user_data'] != null ? new UserData.fromJson(json['user_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['access_expires'] = this.accessExpires;
    data['refresh_expires'] = this.refreshExpires;
    data['user_id'] = this.userId;
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  int id;
  String hoTen;
  String soDienThoai;

  UserData({this.id, this.hoTen, this.soDienThoai});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hoTen = json['ho_ten'];
    soDienThoai = json['so_dien_thoai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ho_ten'] = this.hoTen;
    data['so_dien_thoai'] = this.soDienThoai;
    return data;
  }
}

class RefreshTokenBody {
  String refresh;

  RefreshTokenBody({this.refresh});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    return data;
  }
}
