class LoginModel {
  String? eMail;
  String? password;

  LoginModel({this.eMail, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    eMail = json['e-mail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['e-mail'] = eMail;
    data['password'] = password;
    return data;
  }
}
