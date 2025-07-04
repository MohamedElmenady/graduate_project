class EditModel {
  final String name;
  //final String email;
  final String phone;
  // final String password;

  EditModel({
    required this.name,
    //required this.email,
    required this.phone,
    // required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": name,
      //"email": email,
      "phoneNumber": phone,
      //"password": password,
    };
  }
}
