class SpecialityModel {
  final String id;
  final String name;

  SpecialityModel({required this.id, required this.name});

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    return SpecialityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
