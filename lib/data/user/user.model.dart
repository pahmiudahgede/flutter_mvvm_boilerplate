import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

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

  // Helper method to create new user with generated fields
  static User createNew({
    required String name,
    required String gender,
    required String dateOfBirth,
    required String placeOfBirth,
    required String address,
    required String email,
    required String password,
    String? avatar,
  }) {
    final String userId = _generateCUID();
    final String hashedPassword = _hashPassword(password);
    final String userAvatar = avatar ?? _generateAvatar();
    final String currentDate = _getCurrentDate();

    return User(
      id: userId,
      name: name,
      gender: gender,
      dateOfBirth: dateOfBirth,
      placeOfBirth: placeOfBirth,
      address: address,
      email: email.toLowerCase(),
      password: hashedPassword,
      avatar: userAvatar,
      createdAt: currentDate,
      updatedAt: currentDate,
    );
  }

  // Helper method to create updated user
  User copyWith({
    String? name,
    String? gender,
    String? dateOfBirth,
    String? placeOfBirth,
    String? address,
    String? email,
    String? password,
    String? avatar,
  }) {
    return User(
      id: id, // ID never changes
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      address: address ?? this.address,
      email: email?.toLowerCase() ?? this.email,
      password: password != null ? _hashPassword(password) : this.password,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt, // CreatedAt never changes
      updatedAt: _getCurrentDate(), // Always update timestamp
    );
  }

  // Generate partial update data (only changed fields)
  Map<String, dynamic> toUpdateJson({
    String? name,
    String? gender,
    String? dateOfBirth,
    String? placeOfBirth,
    String? address,
    String? email,
    String? password,
    String? avatar,
  }) {
    final Map<String, dynamic> updateData = {};

    if (name != null) updateData['Name'] = name;
    if (gender != null) updateData['Gender'] = gender;
    if (dateOfBirth != null) updateData['Dateofbirth'] = dateOfBirth;
    if (placeOfBirth != null) updateData['Placeofbirth'] = placeOfBirth;
    if (address != null) updateData['Address'] = address;
    if (email != null) updateData['Email'] = email.toLowerCase();
    if (password != null) updateData['Password'] = _hashPassword(password);
    if (avatar != null) updateData['Avatar'] = avatar;

    // Always update timestamp
    updateData['UpdatedAt'] = _getCurrentDate();

    return updateData;
  }

  // Private helper methods
  static String _generateCUID() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    final randomPart = Random().nextInt(1000000).toRadixString(36);
    final counter = Random().nextInt(1000).toRadixString(36);
    return 'clh$timestamp$randomPart$counter';
  }

  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return '\$2y\$10\$${digest.toString().substring(0, 53)}';
  }

  static String _generateAvatar() {
    final randomNum = Random().nextInt(70) + 1;
    return 'https://i.pravatar.cc/150?img=$randomNum';
  }

  static String _getCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
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

  bool get isSuccess => meta.status >= 200 && meta.status < 300;
  bool get isError => !isSuccess;
}

class Meta {
  final int status;
  final String message;
  final String? timestamp;

  Meta({
    required this.status,
    required this.message,
    this.timestamp,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'],
    );
  }
}