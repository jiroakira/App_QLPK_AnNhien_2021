class AllVisitModel {
  String benhNhan;
  List<Upcoming> upcoming;
  List<Past> past;

  AllVisitModel({this.benhNhan, this.upcoming, this.past});

  AllVisitModel.fromJson(Map<String, dynamic> json) {
    benhNhan = json['benh_nhan'];
    if (json['upcoming'] != null) {
      upcoming = new List<Upcoming>();
      json['upcoming'].forEach((v) {
        upcoming.add(new Upcoming.fromJson(v));
      });
    }
    if (json['past'] != null) {
      past = new List<Past>();
      json['past'].forEach((v) {
        past.add(new Past.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benh_nhan'] = this.benhNhan;
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming.map((v) => v.toJson()).toList();
    }
    if (this.past != null) {
      data['past'] = this.past.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Upcoming {
  int id;
  BenhNhan benhNhan;
  NguoiPhuTrach nguoiPhuTrach;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  String thoiGianTao;
  String thoiGianChinhSua;
  String lyDo;
  String diaDiem;
  String loaiDichVu;
  TrangThai trangThai;
  String actions;

  Upcoming(
      {this.id,
      this.benhNhan,
      this.nguoiPhuTrach,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.lyDo,
      this.diaDiem,
      this.loaiDichVu,
      this.thoiGianTao,
      this.thoiGianChinhSua,
      this.trangThai,
      this.actions});

  Upcoming.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    benhNhan = json['benh_nhan'] != null ? new BenhNhan.fromJson(json['benh_nhan']) : null;
    nguoiPhuTrach = json['nguoi_phu_trach'] != null ? new NguoiPhuTrach.fromJson(json['nguoi_phu_trach']) : null;
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    lyDo = json['ly_do'];
    diaDiem = json['dia_diem'];
    loaiDichVu = json['loai_dich_vu'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianChinhSua = json['thoi_gian_chinh_sua'];
    trangThai = TrangThai.fromJson(json['trang_thai']);
    actions = json['actions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    if (this.nguoiPhuTrach != null) {
      data['nguoi_phu_trach'] = this.nguoiPhuTrach.toJson();
    }
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_chinh_sua'] = this.thoiGianChinhSua;
    data['trang_thai'] = this.trangThai;
    data['actions'] = this.actions;
    return data;
  }
}

class Past {
  int id;
  BenhNhan benhNhan;
  NguoiPhuTrach nguoiPhuTrach;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  String thoiGianTao;
  String thoiGianChinhSua;
  TrangThai trangThai;
  String actions;

  Past(
      {this.id,
      this.benhNhan,
      this.nguoiPhuTrach,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.thoiGianTao,
      this.thoiGianChinhSua,
      this.trangThai,
      this.actions});

  Past.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    benhNhan = json['benh_nhan'] != null ? new BenhNhan.fromJson(json['benh_nhan']) : null;
    nguoiPhuTrach = json['nguoi_phu_trach'] != null ? new NguoiPhuTrach.fromJson(json['nguoi_phu_trach']) : null;
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianChinhSua = json['thoi_gian_chinh_sua'];
    trangThai = TrangThai.fromJson(json['trang_thai']);
    actions = json['actions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    if (this.nguoiPhuTrach != null) {
      data['nguoi_phu_trach'] = this.nguoiPhuTrach.toJson();
    }
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_chinh_sua'] = this.thoiGianChinhSua;
    data['trang_thai'] = this.trangThai;
    data['actions'] = this.actions;
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

class NguoiPhuTrach {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String diaChi;
  String ngaySinh;
  String gioiTinh;

  NguoiPhuTrach({this.id, this.soDienThoai, this.hoTen, this.email, this.cmndCccd, this.diaChi, this.ngaySinh, this.gioiTinh});

  NguoiPhuTrach.fromJson(Map<String, dynamic> json) {
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
