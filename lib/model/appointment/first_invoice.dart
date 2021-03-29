class FirstInvoice {
  Data data;

  FirstInvoice({this.data});

  FirstInvoice.fromJson(Map<String, dynamic> json) {
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
  String tongTien;
  String thoiGianTao;

  Data({this.id, this.tongTien, this.thoiGianTao});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tongTien = json['tong_tien'];
    thoiGianTao = json['thoi_gian_tao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tong_tien'] = this.tongTien;
    data['thoi_gian_tao'] = this.thoiGianTao;
    return data;
  }
}
