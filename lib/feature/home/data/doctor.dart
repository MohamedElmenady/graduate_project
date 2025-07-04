class Doctor {
  final String id;
  final String fullName;
  final String specializationName;
  final String clinicName;
  final double rating;
  final int reviewsCount;
  final String cityName;
  final String governorateName;

  Doctor({
    required this.id,
    required this.fullName,
    required this.specializationName,
    required this.clinicName,
    required this.rating,
    required this.reviewsCount,
    required this.cityName,
    required this.governorateName,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fullName: json['fullName'],
      specializationName: json['specializationName'],
      clinicName: json['clinicName'],
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      cityName: json['cityName'],
      governorateName: json['governorateName'],
    );
  }
}
