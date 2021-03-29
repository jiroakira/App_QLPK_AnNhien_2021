class UpdateAppointmentInfo {
  int status;
  String message;
  Data data;

  UpdateAppointmentInfo({this.status, this.message, this.data});

  UpdateAppointmentInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String loaiDichVu;
  String diaDiem;
  String lyDo;
  String thoiGianBatDau;

  Data({this.loaiDichVu, this.diaDiem, this.lyDo, this.thoiGianBatDau});

  Data.fromJson(Map<String, dynamic> json) {
    loaiDichVu = json['loai_dich_vu'];
    diaDiem = json['dia_diem'];
    lyDo = json['ly_do'];
    thoiGianBatDau = json['thoi_gian_bat_dau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loai_dich_vu'] = this.loaiDichVu;
    data['dia_diem'] = this.diaDiem;
    data['ly_do'] = this.lyDo;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    return data;
  }
}
