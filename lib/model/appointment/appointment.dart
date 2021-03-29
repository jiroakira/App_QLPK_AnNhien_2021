import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final String time;
  final String patient;

  AppointmentModel({this.time, this.patient});

  @override
  List<Object> get props => [time, patient];

  static AppointmentModel fromJson(dynamic json) {
    return AppointmentModel(time: json['time'], patient: json['patient']);
  }

  @override
  String toString() => 'AppointmentModel { time: $time, patient: $patient }';
}

class AllAppointmentModel {
  bool error;
  int status;
  String message;
  List<Data> data;

  AllAppointmentModel({this.error, this.status, this.message, this.data});

  AllAppointmentModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
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
    data['error'] = this.error;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  BenhNhan benhNhan;
  String thoiGianBatDau;
  String thoiGianKetThuc;
  String thoiGianTao;
  String thoiGianChinhSua;
  int nguoiPhuTrach;
  int trangThai;
  String actions;

  Data(
      {this.id,
      this.benhNhan,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.thoiGianTao,
      this.thoiGianChinhSua,
      this.nguoiPhuTrach,
      this.trangThai,
      this.actions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    benhNhan = json['benh_nhan'] != null ? new BenhNhan.fromJson(json['benh_nhan']) : null;
    thoiGianBatDau = json['thoi_gian_bat_dau'];
    thoiGianKetThuc = json['thoi_gian_ket_thuc'];
    thoiGianTao = json['thoi_gian_tao'];
    thoiGianChinhSua = json['thoi_gian_chinh_sua'];
    nguoiPhuTrach = json['nguoi_phu_trach'];
    trangThai = json['trang_thai'];
    actions = json['actions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.benhNhan != null) {
      data['benh_nhan'] = this.benhNhan.toJson();
    }
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['thoi_gian_ket_thuc'] = this.thoiGianKetThuc;
    data['thoi_gian_tao'] = this.thoiGianTao;
    data['thoi_gian_chinh_sua'] = this.thoiGianChinhSua;
    data['nguoi_phu_trach'] = this.nguoiPhuTrach;
    data['trang_thai'] = this.trangThai;
    data['actions'] = this.actions;
    return data;
  }
}

class BenhNhan {
  int id;
  String soDienThoai;
  String hoTen;
  String email;
  String cmndCccd;
  String chucNang;

  BenhNhan({this.id, this.soDienThoai, this.hoTen, this.email, this.cmndCccd, this.chucNang});

  BenhNhan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soDienThoai = json['so_dien_thoai'];
    hoTen = json['ho_ten'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    chucNang = json['chuc_nang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['so_dien_thoai'] = this.soDienThoai;
    data['ho_ten'] = this.hoTen;
    data['email'] = this.email;
    data['cmnd_cccd'] = this.cmndCccd;
    data['chuc_nang'] = this.chucNang;
    return data;
  }
}

class AppointmentRequestModel {
  String benhNhan;
  String thoiGianBatDau;
  String lyDo;
  String diaDiem;
  String loaiDichVu;

  AppointmentRequestModel({this.benhNhan, this.thoiGianBatDau, this.diaDiem, this.loaiDichVu, this.lyDo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benh_nhan'] = this.benhNhan;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['dia_diem'] = this.diaDiem;
    data['loai_dich_vu'] = this.loaiDichVu;
    data['ly_do'] = this.lyDo;
    return data;
  }
}

class UpdateAppointmentRequestModel {
  String appointmentId;
  String thoiGianBatDau;
  String lyDo;
  String diaDiem;
  String loaiDichVu;

  UpdateAppointmentRequestModel({this.appointmentId, this.thoiGianBatDau, this.diaDiem, this.loaiDichVu, this.lyDo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['thoi_gian_bat_dau'] = this.thoiGianBatDau;
    data['dia_diem'] = this.diaDiem;
    data['loai_dich_vu'] = this.loaiDichVu;
    data['ly_do'] = this.lyDo;
    return data;
  }
}

class UpdateAppointmentResponse {
  int status;
  String message;

  UpdateAppointmentResponse({this.status, this.message});

  UpdateAppointmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
