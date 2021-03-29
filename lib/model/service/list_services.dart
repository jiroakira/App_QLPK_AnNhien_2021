class ListServices {
  int status;
  String message;
  List<Data> data;

  ListServices({this.status, this.message, this.data});

  ListServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String maDvkt;
  String tenDvkt;
  String donGia;

  Data({this.maDvkt, this.tenDvkt, this.donGia});

  Data.fromJson(Map<String, dynamic> json) {
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
