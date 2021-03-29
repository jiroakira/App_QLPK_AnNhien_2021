class UpdateUserBody {
  String soDienThoai;
  String hoTen;
  String ngaySinh;
  String gioiTinh;
  String email;
  String cmndCccd;
  String anhDaiDien;
  String diaChi;

  UpdateUserBody({this.soDienThoai, this.hoTen, this.ngaySinh, this.gioiTinh, this.email, this.cmndCccd, this.anhDaiDien, this.diaChi});

  UpdateUserBody.fromJson(Map<String, dynamic> json) {
    soDienThoai = json['so_dien_thoai'];
    hoTen = json['ho_ten'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    anhDaiDien = json['anh_dai_dien'];
    diaChi = json['dia_chi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['so_dien_thoai'] = this.soDienThoai;
    data['ho_ten'] = this.hoTen;
    data['ngay_sinh'] = this.ngaySinh;
    data['gioi_tinh'] = this.gioiTinh;
    data['email'] = this.email;
    data['cmnd_cccd'] = this.cmndCccd;
    data['anh_dai_dien'] = this.anhDaiDien;
    data['dia_chi'] = this.diaChi;
    return data;
  }
}
