class TestResultBody {
  List<Data> data;

  TestResultBody({this.data});

  TestResultBody.fromJson(Map<String, dynamic> json) {
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
  String dichVu;
  ChiSoXetNghiem chiSoXetNghiem;
  String ketQuaXetNghiem;
  String danhGiaChiSo;
  String danhGiaGhiChu;

  Data({this.dichVu, this.chiSoXetNghiem, this.ketQuaXetNghiem, this.danhGiaChiSo, this.danhGiaGhiChu});

  Data.fromJson(Map<String, dynamic> json) {
    dichVu = json['dich_vu'];
    chiSoXetNghiem = json['chi_so_xet_nghiem'] != null ? new ChiSoXetNghiem.fromJson(json['chi_so_xet_nghiem']) : null;
    ketQuaXetNghiem = json['ket_qua_xet_nghiem'];
    danhGiaChiSo = json['danh_gia_chi_so'];
    danhGiaGhiChu = json['danh_gia_ghi_chu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dich_vu'] = this.dichVu;
    if (this.chiSoXetNghiem != null) {
      data['chi_so_xet_nghiem'] = this.chiSoXetNghiem.toJson();
    }
    data['ket_qua_xet_nghiem'] = this.ketQuaXetNghiem;
    data['danh_gia_chi_so'] = this.danhGiaChiSo;
    data['danh_gia_ghi_chu'] = this.danhGiaGhiChu;
    return data;
  }
}

class ChiSoXetNghiem {
  int id;
  ChiTiet chiTiet;
  String maChiSo;
  String tenChiSo;
  int dichVuKham;
  int doiTuongXetNghiem;

  ChiSoXetNghiem({this.id, this.chiTiet, this.maChiSo, this.tenChiSo, this.dichVuKham, this.doiTuongXetNghiem});

  ChiSoXetNghiem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chiTiet = json['chi_tiet'] != null ? new ChiTiet.fromJson(json['chi_tiet']) : null;
    maChiSo = json['ma_chi_so'];
    tenChiSo = json['ten_chi_so'];
    dichVuKham = json['dich_vu_kham'];
    doiTuongXetNghiem = json['doi_tuong_xet_nghiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.chiTiet != null) {
      data['chi_tiet'] = this.chiTiet.toJson();
    }
    data['ma_chi_so'] = this.maChiSo;
    data['ten_chi_so'] = this.tenChiSo;
    data['dich_vu_kham'] = this.dichVuKham;
    data['doi_tuong_xet_nghiem'] = this.doiTuongXetNghiem;
    return data;
  }
}

class ChiTiet {
  int id;
  String chiSoBinhThuongMin;
  String chiSoBinhThuongMax;
  String chiSoBinhThuong;
  String donViDo;
  String ghiChu;

  ChiTiet({this.id, this.chiSoBinhThuongMin, this.chiSoBinhThuongMax, this.chiSoBinhThuong, this.donViDo, this.ghiChu});

  ChiTiet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chiSoBinhThuongMin = json['chi_so_binh_thuong_min'];
    chiSoBinhThuongMax = json['chi_so_binh_thuong_max'];
    chiSoBinhThuong = json['chi_so_binh_thuong'];
    donViDo = json['don_vi_do'];
    ghiChu = json['ghi_chu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chi_so_binh_thuong_min'] = this.chiSoBinhThuongMin;
    data['chi_so_binh_thuong_max'] = this.chiSoBinhThuongMax;
    data['chi_so_binh_thuong'] = this.chiSoBinhThuong;
    data['don_vi_do'] = this.donViDo;
    data['ghi_chu'] = this.ghiChu;
    return data;
  }
}
