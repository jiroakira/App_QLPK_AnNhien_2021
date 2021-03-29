import 'dart:convert';

class UserUpdateRequestModel {
  String hoTen;
  String email;
  String cmndCccd;
  String ngaySinh;
  String gioiTinh;
  String diaChi;

  UserUpdateRequestModel({
    this.hoTen,
    this.email,
    this.cmndCccd,
    this.ngaySinh,
    this.gioiTinh,
    this.diaChi,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ho_ten'] = this.hoTen;
    data['email'] = this.email;
    data['cmnd_cccd'] = this.cmndCccd;
    data['ngay_sinh'] = this.ngaySinh;
    data['gioi_tinh'] = this.gioiTinh;
    data['dia_chi'] = this.diaChi;
    return data;
  }
}
