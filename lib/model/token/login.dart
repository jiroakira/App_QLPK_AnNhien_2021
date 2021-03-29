class LoginBody {
  String soDienThoai;
  String password;

  LoginBody({this.soDienThoai, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['so_dien_thoai'] = this.soDienThoai;
    data['password'] = this.password;
    return data;
  }
}

class LoginError {
  String errorMessage;
  int errorCode;

  LoginError({this.errorMessage, this.errorCode});

  LoginError.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_message'] = this.errorMessage;
    data['error_code'] = this.errorCode;
    return data;
  }
}
