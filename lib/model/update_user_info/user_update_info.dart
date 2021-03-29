class UserUpdateInfoBody {
  int status;
  Data data;

  UserUpdateInfoBody({this.status, this.data});

  UserUpdateInfoBody.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  String hoTen;
  String soDienThoai;
  String email;
  String cmndCccd;
  String ngaySinh;
  String gioiTinh;
  String diaChi;
  String danToc;
  String maSoBaoHiem;

  Data({this.id, this.hoTen, this.soDienThoai, this.email, this.cmndCccd, this.ngaySinh, this.gioiTinh, this.diaChi, this.danToc, this.maSoBaoHiem});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hoTen = json['ho_ten'];
    soDienThoai = json['so_dien_thoai'];
    email = json['email'];
    cmndCccd = json['cmnd_cccd'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
    diaChi = json['dia_chi'];
    danToc = json['dan_toc'];
    maSoBaoHiem = json['ma_so_bao_hiem'];
  }
}

class UserUpdateInfoRequestBody {
  String benhNhan;
  String hoTen;
  String soDienThoai;
  String cmndCccd;
  String email;
  String ngaySinh;
  String gioiTinh;
  String diaChi;
  String danToc;
  String maSoBaoHiem;

  UserUpdateInfoRequestBody(
      {this.benhNhan,
      this.hoTen,
      this.soDienThoai,
      this.cmndCccd,
      this.email,
      this.ngaySinh,
      this.gioiTinh,
      this.diaChi,
      this.danToc,
      this.maSoBaoHiem});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benh_nhan'] = this.benhNhan;
    data['ho_ten'] = this.hoTen;
    data['so_dien_thoai'] = this.soDienThoai;
    data['cmnd_cccd'] = this.cmndCccd;
    data['email'] = this.email;
    data['ngay_sinh'] = this.ngaySinh;
    data['gioi_tinh'] = this.gioiTinh;
    data['dia_chi'] = this.diaChi;
    data['dan_toc'] = this.danToc;
    data['ma_so_bao_hiem'] = this.maSoBaoHiem;
    return data;
  }
}

class ResponseUserUpdateInfoBody {
  int status;
  String message;

  ResponseUserUpdateInfoBody({this.status, this.message});

  ResponseUserUpdateInfoBody.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
