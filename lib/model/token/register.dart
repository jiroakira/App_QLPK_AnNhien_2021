class RegisterBody {
  String hoTen;
  String soDienThoai;
  String cmndCccd;
  String diaChi;
  String password;

  RegisterBody({this.hoTen, this.soDienThoai, this.password, this.cmndCccd, this.diaChi});

  RegisterBody.fromJson(Map<String, dynamic> json) {
    hoTen = json['ho_ten'];
    soDienThoai = json['so_dien_thoai'];
    cmndCccd = json['cmnd_cccd'];
    diaChi = json['dia_chi'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ho_ten'] = this.hoTen;
    data['so_dien_thoai'] = this.soDienThoai;
    data['cmnd_cccd'] = this.cmndCccd;
    data['dia_chi'] = this.diaChi;
    data['password'] = this.password;
    return data;
  }
}

class RegisterResponse {
  User user;
  int status;
  String message;

  RegisterResponse({this.user, this.status, this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      user: User.fromJson(json['user']),
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class User {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String chucNang;

  User({this.id, this.soDienThoai, this.hoTen, this.email, this.cmndCccd, this.chucNang});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      soDienThoai: json['so_dien_thoai'],
      hoTen: json['ho_ten'],
      email: json['email'],
      cmndCccd: json['cmnd_cccd'],
      chucNang: json['chuc_nang'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['so_dien_thoai'] = this.soDienThoai;
    data['ho_ten'] = this.hoTen;
    data['email'] = this.email;
    data['cmnd_cccd'] = this.cmndCccd;
    data['chuc_nang'] = this.chucNang;
    return data;
  }
}
