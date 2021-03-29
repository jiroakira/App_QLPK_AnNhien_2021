class ListDoctorBody {
  List<Data> data;

  ListDoctorBody({this.data});

  ListDoctorBody.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  User user;
  String gioiThieu;
  String chucDanh;
  String chuyenKhoa;
  String noiCongTac;
  String kinhNghiem;
  String loaiCongViec;

  Data({this.id, this.user, this.gioiThieu, this.chucDanh, this.chuyenKhoa, this.noiCongTac, this.kinhNghiem, this.loaiCongViec});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    gioiThieu = json['gioi_thieu'];
    chucDanh = json['chuc_danh'];
    chuyenKhoa = json['chuyen_khoa'];
    noiCongTac = json['noi_cong_tac'];
    kinhNghiem = json['kinh_nghiem'];
    loaiCongViec = json['loai_cong_viec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['gioi_thieu'] = this.gioiThieu;
    data['chuc_danh'] = this.chucDanh;
    data['chuyen_khoa'] = this.chuyenKhoa;
    data['noi_cong_tac'] = this.noiCongTac;
    data['kinh_nghiem'] = this.kinhNghiem;
    data['loai_cong_viec'] = this.loaiCongViec;
    return data;
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
  String anhDaiDien;
  String maSoBaoHiem;

  User(
      {this.id,
      this.soDienThoai,
      this.hoTen,
      this.email,
      this.cmndCccd,
      this.diaChi,
      this.ngaySinh,
      this.gioiTinh,
      this.maBenhNhan,
      this.danToc,
      this.anhDaiDien,
      this.maSoBaoHiem});

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
    anhDaiDien = json['anh_dai_dien'];
    maSoBaoHiem = json['ma_so_bao_hiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['so_dien_thoai'] = this.soDienThoai;
    data['ho_ten'] = this.hoTen;
    data['email'] = this.email;
    data['cmnd_cccd'] = this.cmndCccd;
    data['dia_chi'] = this.diaChi;
    data['ngay_sinh'] = this.ngaySinh;
    data['gioi_tinh'] = this.gioiTinh;
    data['ma_benh_nhan'] = this.maBenhNhan;
    data['dan_toc'] = this.danToc;
    data['anh_dai_dien'] = this.anhDaiDien;
    data['ma_so_bao_hiem'] = this.maSoBaoHiem;
    return data;
  }
}
