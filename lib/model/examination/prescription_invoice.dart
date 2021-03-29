class PrescriptionInvoice {
  int tongTien;
  int apDungBaoHiem;
  int thanhTien;
  List<Data> data;

  PrescriptionInvoice({this.tongTien, this.apDungBaoHiem, this.thanhTien, this.data});

  PrescriptionInvoice.fromJson(Map<String, dynamic> json) {
    tongTien = json['tong_tien'];
    apDungBaoHiem = json['ap_dung_bao_hiem'];
    thanhTien = json['thanh_tien'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tong_tien'] = this.tongTien;
    data['ap_dung_bao_hiem'] = this.apDungBaoHiem;
    data['thanh_tien'] = this.thanhTien;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Thuoc thuoc;
  int soLuong;
  bool baoHiem;

  Data({this.thuoc, this.soLuong, this.baoHiem});

  Data.fromJson(Map<String, dynamic> json) {
    thuoc = json['thuoc'] != null ? new Thuoc.fromJson(json['thuoc']) : null;
    soLuong = json['so_luong'];
    baoHiem = json['bao_hiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thuoc != null) {
      data['thuoc'] = this.thuoc.toJson();
    }
    data['so_luong'] = this.soLuong;
    data['bao_hiem'] = this.baoHiem;
    return data;
  }
}

class Thuoc {
  String tenThuoc;
  String donGiaTt;

  Thuoc({this.tenThuoc, this.donGiaTt});

  Thuoc.fromJson(Map<String, dynamic> json) {
    tenThuoc = json['ten_thuoc'];
    donGiaTt = json['don_gia_tt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ten_thuoc'] = this.tenThuoc;
    data['don_gia_tt'] = this.donGiaTt;
    return data;
  }
}
