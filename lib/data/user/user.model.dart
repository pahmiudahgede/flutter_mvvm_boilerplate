class User {
  final String id;
  final String name;
  final String gender;
  final String dateOfBirth;
  final String placeOfBirth;
  final String address;
  final String email;
  final String password;
  final String avatar;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.address,
    required this.email,
    required this.password,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'] ?? '',
      name: json['Name'] ?? '',
      gender: json['Gender'] ?? '',
      dateOfBirth: json['Dateofbirth'] ?? '',
      placeOfBirth: json['Placeofbirth'] ?? '',
      address: json['Address'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      avatar: json['Avatar'] ?? '',
      createdAt: json['CreatedAt'] ?? '',
      updatedAt: json['UpdatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Gender': gender,
      'Dateofbirth': dateOfBirth,
      'Placeofbirth': placeOfBirth,
      'Address': address,
      'Email': email,
      'Password': password,
      'Avatar': avatar,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }
}

class ApiResponse<T> {
  final Meta meta;
  final List<T> data;

  ApiResponse({
    required this.meta,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      meta: Meta.fromJson(json['meta']),
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
    );
  }
}

class Meta {
  final int status;
  final String message;

  Meta({
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}