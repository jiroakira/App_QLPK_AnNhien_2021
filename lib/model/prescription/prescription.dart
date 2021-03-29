class PrescriptionBody {
  int donThuoc;
  List<Data> data;

  PrescriptionBody({this.donThuoc, this.data});

  PrescriptionBody.fromJson(Map<String, dynamic> json) {
    donThuoc = json['don_thuoc'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['don_thuoc'] = this.donThuoc;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  Thuoc thuoc;
  int soLuong;
  String cachDung;
  String ghiChu;

  Data({this.id, this.thuoc, this.soLuong, this.cachDung, this.ghiChu});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thuoc = json['thuoc'] != null ? new Thuoc.fromJson(json['thuoc']) : null;
    soLuong = json['so_luong'];
    cachDung = json['cach_dung'];
    ghiChu = json['ghi_chu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.thuoc != null) {
      data['thuoc'] = this.thuoc.toJson();
    }
    data['so_luong'] = this.soLuong;
    data['cach_dung'] = this.cachDung;
    data['ghi_chu'] = this.ghiChu;
    return data;
  }
}

class Thuoc {
  String id;
  String tenThuoc;
  String duongDung;
  String donViTinh;

  Thuoc({this.id, this.tenThuoc, this.duongDung, this.donViTinh});

  Thuoc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenThuoc = json['ten_thuoc'];
    duongDung = json['duong_dung'];
    donViTinh = json['don_vi_tinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten_thuoc'] = this.tenThuoc;
    data['duong_dung'] = this.duongDung;
    data['don_vi_tinh'] = this.donViTinh;
    return data;
  }
}
