class LatestCheckupProcessBody {
  Data data;

  LatestCheckupProcessBody({this.data});

  LatestCheckupProcessBody.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  BenhNhan benhNhan;
  BacSiDamNhan bacSiDamNhan;
  TrangThai trangThai;

  Data({this.id, this.thoiGianBatDau, this.thoiGianKetThuc, this.benhNhan, this.bacSiDamNhan, this.trangThai});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    benhNhan = json['benh_nhan'] != null ? new BenhNhan.fromJson(json['benh_nhan']) : null;
    bacSiDamNhan = json['bac_si_dam_nhan'] != null ? new BacSiDamNhan.fromJson(json['bac_si_dam_nhan']) : null;
    trangThai = TrangThai.fromJson(json['trang_thai']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    if (this.bacSiDamNhan != null) {
      data['bac_si_dam_nhan'] = this.bacSiDamNhan.toJson();
    }
    data['trang_thai'] = this.trangThai;
    return data;
  }
}

class BenhNhan {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String diaChi;
  String ngaySinh;
  String gioiTinh;

  BenhNhan({this.id, this.soDienThoai, this.hoTen, this.email, this.cmndCccd, this.diaChi, this.ngaySinh, this.gioiTinh});

  BenhNhan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soDienThoai = json['so_dien_thoai'];
    hoTen = json['ho_ten'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    diaChi = json['dia_chi'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
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
    return data;
  }
}

class BacSiDamNhan {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String diaChi;
  String ngaySinh;
  String gioiTinh;

  BacSiDamNhan({this.id, this.soDienThoai, this.hoTen, this.email, this.cmndCccd, this.diaChi, this.ngaySinh, this.gioiTinh});

  BacSiDamNhan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soDienThoai = json['so_dien_thoai'];
    hoTen = json['ho_ten'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    diaChi = json['dia_chi'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
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
    return data;
  }
}

class TrangThai {
  int id;
  String trangThaiChuoiKham;

  TrangThai({this.id, this.trangThaiChuoiKham});

  TrangThai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trangThaiChuoiKham = json['trang_thai_chuoi_kham'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trang_thai_chuoi_kham'] = this.trangThaiChuoiKham;
    return data;
  }
}
