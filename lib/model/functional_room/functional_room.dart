class FunctionalRoom {
  List<Data> data;

  FunctionalRoom({this.data});

  FunctionalRoom.fromJson(Map<String, dynamic> json) {
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
  String tenPhongChucNang;
  String thoiGianTao;
  String thoiGianCapNhat;

  Data({this.id, this.tenPhongChucNang, this.thoiGianTao, this.thoiGianCapNhat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenPhongChucNang = json['ten_phong_chuc_nang'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianCapNhat = json['thoi_gian_cap_nhat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten_phong_chuc_nang'] = this.tenPhongChucNang;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_cap_nhat'] = this.thoiGianCapNhat;
    return data;
  }
}
