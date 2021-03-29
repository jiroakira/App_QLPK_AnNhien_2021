class AppointmentResponseModel {
  bool error;
  int status;
  String message;
  Data data;

  AppointmentResponseModel({this.error, this.status, this.message, this.data});

  factory AppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return AppointmentResponseModel(
      error: json['error'],
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  BenhNhan benhNhan;
  String thoiGianBatDau;
  TrangThai trangThai;

  Data({this.id, this.benhNhan, this.thoiGianBatDau, this.trangThai});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      benhNhan: BenhNhan.fromJson(json['benh_nhan']),
      thoiGianBatDau: json['thoi_gian_bat_dau'],
      trangThai: TrangThai.fromJson(json['trang_thai']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    if (this.trangThai != null) {
      data['trang_thai'] = this.trangThai.toJson();
    }
    return data;
  }
}

class BenhNhan {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String chucNang;

  BenhNhan(
      {this.id,
      this.soDienThoai,
      this.hoTen,
      this.email,
      this.cmndCccd,
      this.chucNang});

  factory BenhNhan.fromJson(Map<String, dynamic> json) {
    return BenhNhan(
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

class TrangThai {
  int id;
  String tenTrangThai;

  TrangThai({this.id, this.tenTrangThai});

  factory TrangThai.fromJson(Map<String, dynamic> json) {
    return TrangThai(
      id: json['id'],
      tenTrangThai: json['ten_trang_thai'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten_trang_thai'] = this.tenTrangThai;
    return data;
  }
}
