class ResponseAppointment {
  int status;
  String message;
  BenhNhan benhNhan;
  LichHen lichHen;

  ResponseAppointment({
    this.status,
    this.message,
    this.benhNhan,
    this.lichHen,
  });

  ResponseAppointment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    benhNhan = json['benh_nhan'] != null ? new BenhNhan.fromJson(json['benh_nhan']) : null;
    lichHen = json['lich_hen'] != null ? new LichHen.fromJson(json['lich_hen']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    if (this.lichHen != null) {
      data['lich_hen'] = this.lichHen.toJson();
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

class LichHen {
  int id;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  TrangThai trangThai;
  String diaDiem;
  String lyDo;
  String loaiDichVu;

  LichHen({
    this.id,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.trangThai,
    this.diaDiem,
    this.lyDo,
    this.loaiDichVu,
  });

  LichHen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    trangThai = json['trang_thai'] != null ? new TrangThai.fromJson(json['trang_thai']) : null;
    diaDiem = json['dia_diem'];
    lyDo = json['ly_do'];
    loaiDichVu = json['loai_dich_vu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    if (this.trangThai != null) {
      data['trang_thai'] = this.trangThai.toJson();
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
