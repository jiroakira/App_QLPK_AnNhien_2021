class ExaminationsInvoice {
  double tongTien;
  double apDungBaoHiem;
  double thanhTien;
  List<Data> data;

  ExaminationsInvoice({this.tongTien, this.apDungBaoHiem, this.thanhTien, this.data});

  ExaminationsInvoice.fromJson(Map<String, dynamic> json) {
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
  DichVuKham dichVuKham;
  bool baoHiem;
  int priority;

  Data({this.dichVuKham, this.baoHiem, this.priority});

  Data.fromJson(Map<String, dynamic> json) {
    dichVuKham = json['dich_vu_kham'] != null ? new DichVuKham.fromJson(json['dich_vu_kham']) : null;
    baoHiem = json['bao_hiem'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dichVuKham != null) {
      data['dich_vu_kham'] = this.dichVuKham.toJson();
    }
    data['bao_hiem'] = this.baoHiem;
    data['priority'] = this.priority;
    return data;
  }
}

class DichVuKham {
  String maDvkt;
  String tenDvkt;
  String donGia;

  DichVuKham({this.maDvkt, this.tenDvkt, this.donGia});

  DichVuKham.fromJson(Map<String, dynamic> json) {
    maDvkt = json['ma_dvkt'];
    tenDvkt = json['ten_dvkt'];
    donGia = json['don_gia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_dvkt'] = this.maDvkt;
    data['ten_dvkt'] = this.tenDvkt;
    data['don_gia'] = this.donGia;
    return data;
  }
}
