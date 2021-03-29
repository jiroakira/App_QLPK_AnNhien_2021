class ListPrescriptionBody {
  String benhNhan;
  List<Data> data;

  ListPrescriptionBody({this.benhNhan, this.data});

  ListPrescriptionBody.fromJson(Map<String, dynamic> json) {
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
  String maDonThuoc;
  BacSiKeDon bacSiKeDon;

  Data({this.id, this.maDonThuoc, this.bacSiKeDon});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maDonThuoc = json['ma_don_thuoc'];
    bacSiKeDon = json['bac_si_ke_don'] != null ? new BacSiKeDon.fromJson(json['bac_si_ke_don']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ma_don_thuoc'] = this.maDonThuoc;
    if (this.bacSiKeDon != null) {
      data['bac_si_ke_don'] = this.bacSiKeDon.toJson();
    }
    return data;
  }
}

class BacSiKeDon {
  int id;
  String hoTen;
  String soDienThoai;

  BacSiKeDon({this.id, this.hoTen, this.soDienThoai});

  BacSiKeDon.fromJson(Map<String, dynamic> json) {
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
