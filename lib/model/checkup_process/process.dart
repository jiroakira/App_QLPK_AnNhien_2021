class CheckupProcessBody {
  String benhNhan;
  List<Data> data;

  CheckupProcessBody({this.benhNhan, this.data});

  CheckupProcessBody.fromJson(Map<String, dynamic> json) {
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
  int priority;
  DichVuKham dichVuKham;
  TrangThai trangThai;

  Data({this.id, this.priority, this.dichVuKham, this.trangThai});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    dichVuKham = json['dich_vu_kham'] != null ? new DichVuKham.fromJson(json['dich_vu_kham']) : null;
    trangThai = json['trang_thai'] != null ? new TrangThai.fromJson(json['trang_thai']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priority'] = this.priority;
    if (this.dichVuKham != null) {
      data['dich_vu_kham'] = this.dichVuKham.toJson();
    }
    if (this.trangThai != null) {
      data['trang_thai'] = this.trangThai.toJson();
    }
    return data;
  }
}

class DichVuKham {
  int id;
  String maDvkt;
  String tenDvkt;
  String maCosokcb;
  PhongChucNang phongChucNang;

  DichVuKham({this.id, this.maDvkt, this.tenDvkt, this.maCosokcb, this.phongChucNang});

  DichVuKham.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maDvkt = json['ma_dvkt'];
    tenDvkt = json['ten_dvkt'];
    maCosokcb = json['ma_cosokcb'];
    phongChucNang = json['phong_chuc_nang'] != null ? new PhongChucNang.fromJson(json['phong_chuc_nang']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ma_dvkt'] = this.maDvkt;
    data['ten_dvkt'] = this.tenDvkt;
    data['ma_cosokcb'] = this.maCosokcb;
    if (this.phongChucNang != null) {
      data['phong_chuc_nang'] = this.phongChucNang.toJson();
    }
    return data;
  }
}

class PhongChucNang {
  int id;
  Null bacSiPhuTrach;
  String tenPhongChucNang;
  String thoiGianTao;
  String thoiGianCapNhat;

  PhongChucNang({this.id, this.bacSiPhuTrach, this.tenPhongChucNang, this.thoiGianTao, this.thoiGianCapNhat});

  PhongChucNang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bacSiPhuTrach = json['bac_si_phu_trach'];
    tenPhongChucNang = json['ten_phong_chuc_nang'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianCapNhat = json['thoi_gian_cap_nhat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bac_si_phu_trach'] = this.bacSiPhuTrach;
    data['ten_phong_chuc_nang'] = this.tenPhongChucNang;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_cap_nhat'] = this.thoiGianCapNhat;
    return data;
  }
}

class TrangThai {
  int id;
  String trangThaiKhoaKham;

  TrangThai({this.id, this.trangThaiKhoaKham});

  TrangThai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trangThaiKhoaKham = json['trang_thai_khoa_kham'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trang_thai_khoa_kham'] = this.trangThaiKhoaKham;
    return data;
  }
}
