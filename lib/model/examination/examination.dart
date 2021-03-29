class ExaminationBody {
  String chuoiKham;
  List<Data> data;

  ExaminationBody({this.chuoiKham, this.data});

  ExaminationBody.fromJson(Map<String, dynamic> json) {
    chuoiKham = json['chuoi_kham'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int id;
  String maKetQua;
  String moTa;
  String ketLuan;
  List<FileTongQuat> fileTongQuat;
  List<KqChuyenKhoa> kqChuyenKhoa;

  Data({this.id, this.maKetQua, this.moTa, this.ketLuan, this.fileTongQuat, this.kqChuyenKhoa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maKetQua = json['ma_ket_qua'];
    moTa = json['mo_ta'];
    ketLuan = json['ket_luan'];
    if (json['file_tong_quat'] != null) {
      fileTongQuat = new List<FileTongQuat>();
      json['file_tong_quat'].forEach((v) {
        fileTongQuat.add(new FileTongQuat.fromJson(v));
      });
    }
    if (json['kq_chuyen_khoa'] != null) {
      kqChuyenKhoa = new List<KqChuyenKhoa>();
      json['kq_chuyen_khoa'].forEach((v) {
        kqChuyenKhoa.add(new KqChuyenKhoa.fromJson(v));
      });
    }
  }
}

class FileTongQuat {
  int id;
  FileKetQua fileKetQua;

  FileTongQuat({this.id, this.fileKetQua});

  FileTongQuat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileKetQua = json['file_ket_qua'] != null ? new FileKetQua.fromJson(json['file_ket_qua']) : null;
  }
}

class KqChuyenKhoa {
  int id;
  String tenDichVu;
  String maKetQua;
  String moTa;
  String ketLuan;
  List<FileChuyenKhoa> fileChuyenKhoa;
  bool chiSo;
  bool html;

  KqChuyenKhoa({this.id, this.tenDichVu, this.maKetQua, this.moTa, this.ketLuan, this.fileChuyenKhoa, this.chiSo, this.html});

  KqChuyenKhoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenDichVu = json['ten_dich_vu'];
    maKetQua = json['ma_ket_qua'];
    moTa = json['mo_ta'];
    ketLuan = json['ket_luan'];
    if (json['file_chuyen_khoa'] != null) {
      fileChuyenKhoa = new List<FileChuyenKhoa>();
      json['file_chuyen_khoa'].forEach((v) {
        fileChuyenKhoa.add(new FileChuyenKhoa.fromJson(v));
      });
    }
    chiSo = json['chi_so'];
    html = json['html'];
  }
}

class FileChuyenKhoa {
  int id;
  FileKetQua fileKetQua;

  FileChuyenKhoa({this.id, this.fileKetQua});

  FileChuyenKhoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileKetQua = FileKetQua.fromJson(json['file_ket_qua']);
  }
}

class FileKetQua {
  int id;
  String file;
  String thoiGianTao;

  FileKetQua({this.id, this.file, this.thoiGianTao});

  FileKetQua.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    thoiGianTao = json['thoi_gian_tao'];
  }
}
