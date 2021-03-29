class ListExaminationsBody {
  String benhNhan;
  List<Data> data;

  ListExaminationsBody({this.benhNhan, this.data});

  ListExaminationsBody.fromJson(Map<String, dynamic> json) {
    benhNhan = json['benh_nhan'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benh_nhan'] = this.benhNhan;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  TrangThai trangThai;
  List<ChuoiKham> chuoiKham;

  Data({this.id, this.thoiGianBatDau, this.thoiGianKetThuc, this.trangThai, this.chuoiKham});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    trangThai = json['trang_thai'] != null ? new TrangThai.fromJson(json['trang_thai']) : null;
    if (json['chuoi_kham'] != null) {
      chuoiKham = new List<ChuoiKham>();
      json['chuoi_kham'].forEach((v) {
        chuoiKham.add(new ChuoiKham.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    if (this.trangThai != null) {
      data['trang_thai'] = this.trangThai.toJson();
    }
    if (this.chuoiKham != null) {
      data['chuoi_kham'] = this.chuoiKham.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrangThai {
  int id;
  String tenTrangThai;

  TrangThai({this.id, this.tenTrangThai});

  TrangThai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenTrangThai = json['ten_trang_thai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten_trang_thai'] = this.tenTrangThai;
    return data;
  }
}

class ChuoiKham {
  int id;
  BacSiDamNhan bacSiDamNhan;
  String thoiGianBatDau;
  String thoiGianKetThuc;

  ChuoiKham({this.id, this.bacSiDamNhan, this.thoiGianBatDau, this.thoiGianKetThuc});

  ChuoiKham.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bacSiDamNhan = json['bac_si_dam_nhan'] != null ? new BacSiDamNhan.fromJson(json['bac_si_dam_nhan']) : null;
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.bacSiDamNhan != null) {
      data['bac_si_dam_nhan'] = this.bacSiDamNhan.toJson();
    }
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    return data;
  }
}

class BacSiDamNhan {
  int id;
  String hoTen;
  String soDienThoai;

  BacSiDamNhan({this.id, this.hoTen, this.soDienThoai});

  BacSiDamNhan.fromJson(Map<String, dynamic> json) {
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
