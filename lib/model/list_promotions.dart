class ListPromotions {
  List<Data> data;

  ListPromotions({this.data});

  ListPromotions.fromJson(Map<String, dynamic> json) {
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
  String tieuDe;
  String hinhAnh;
  String noiDungChinh;
  String noiDung;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  String thoiGianTao;
  int nguoiDangBai;

  Data({
    this.id,
    this.tieuDe,
    this.hinhAnh,
    this.noiDungChinh,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.thoiGianTao,
    this.nguoiDangBai,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tieuDe = json['tieu_de'];
    hinhAnh = json['hinh_anh'];
    noiDungChinh = json['noi_dung_chinh'];
    noiDung = json['noi_dung'];
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    thoiGianTao = json['thoi_gian_tao'];
    nguoiDangBai = json['nguoi_dang_bai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tieu_de'] = this.tieuDe;
    data['hinh_anh'] = this.hinhAnh;
    data['noi_dung_chinh'] = this.noiDungChinh;
    data['noi_dung'] = this.noiDung;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['nguoi_dang_bai'] = this.nguoiDangBai;
    return data;
  }
}
