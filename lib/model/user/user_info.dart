class UserInforBody {
  User user;

  UserInforBody({this.user});

  UserInforBody.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String diaChi;
  String ngaySinh;
  String gioiTinh;
  String maBenhNhan;
  String danToc;
  String maSoBaoHiem;
  String anhDaiDien;

  User({
    this.id,
    this.soDienThoai,
    this.hoTen,
    this.email,
    this.cmndCccd,
    this.diaChi,
    this.ngaySinh,
    this.gioiTinh,
    this.maBenhNhan,
    this.danToc,
    this.maSoBaoHiem,
    this.anhDaiDien,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soDienThoai = json['so_dien_thoai'];
    hoTen = json['ho_ten'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    diaChi = json['dia_chi'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
    maBenhNhan = json['ma_benh_nhan'];
    danToc = json['dan_toc'];
    maSoBaoHiem = json['ma_so_bao_hiem'];
    anhDaiDien = json['anh_dai_dien'];
  }
}
