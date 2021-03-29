class UpcomingVisit {
  Data data;

  UpcomingVisit({this.data});

  UpcomingVisit.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  BenhNhan benhNhan;
  NguoiPhuTrach nguoiPhuTrach;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  String thoiGianTao;
  String thoiGianChinhSua;
  TrangThai trangThai;
  String actions;

  Data(
      {this.id,
      this.benhNhan,
      this.nguoiPhuTrach,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.thoiGianTao,
      this.thoiGianChinhSua,
      this.trangThai,
      this.actions});

  Data.fromJson(Map<String, dynamic> json) {
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
