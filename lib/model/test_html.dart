class TestHtmlBody {
  Data data;

  TestHtmlBody({this.data});

  TestHtmlBody.fromJson(Map<String, dynamic> json) {
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
  String noiDung;
  int phanKhoaKham;
  int ketQuaChuyenKhoa;

  Data({this.id, this.noiDung, this.phanKhoaKham, this.ketQuaChuyenKhoa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noiDung = json['noi_dung'];
    phanKhoaKham = json['phan_khoa_kham'];
    ketQuaChuyenKhoa = json['ket_qua_chuyen_khoa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['noi_dung'] = this.noiDung;
    data['phan_khoa_kham'] = this.phanKhoaKham;
    data['ket_qua_chuyen_khoa'] = this.ketQuaChuyenKhoa;
    return data;
  }
}
