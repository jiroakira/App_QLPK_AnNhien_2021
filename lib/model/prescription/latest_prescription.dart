class LatestPrescription {
  Data data;

  LatestPrescription({this.data});

  LatestPrescription.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String maDonThuoc;
  String thoiGianTao;
  String thoiGianCapNhat;
  int benhNhan;
  int bacSiKeDon;
  int trangThai;

  Data({this.id, this.maDonThuoc, this.thoiGianTao, this.thoiGianCapNhat, this.benhNhan, this.bacSiKeDon, this.trangThai});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maDonThuoc = json['ma_don_thuoc'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianCapNhat = json['thoi_gian_cap_nhat'];
    benhNhan = json['benh_nhan'];
    bacSiKeDon = json['bac_si_ke_don'];
    trangThai = json['trang_thai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ma_don_thuoc'] = this.maDonThuoc;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_cap_nhat'] = this.thoiGianCapNhat;
    data['benh_nhan'] = this.benhNhan;
    data['bac_si_ke_don'] = this.bacSiKeDon;
    data['trang_thai'] = this.trangThai;
    return data;
  }
}
