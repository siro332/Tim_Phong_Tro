class LoginRequest {
  late String email;
  late String password;

  LoginRequest({String email = "", String password = ""}) {
    this.email = email;
    this.password = password;
  }
  String get getEmail => this.email;
  String get getPassword => this.password;
}
