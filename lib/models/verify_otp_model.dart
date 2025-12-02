class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponse({required this.success, required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class LoginData {
  final User user;
  final String token;

  LoginData({required this.user, required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token};
  }
}

class User {
  final String id;
  final String name;
  final String phone;
  final String role;
  final bool isVerified;
  final Profile? profile;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.isVerified,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      isVerified: json['isVerified'] ?? false,
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'profile': profile?.toJson(),
    };
  }
}

class Profile {
  final String dateOfBirth;
  final String gender;
  final Location? location;

  Profile({required this.dateOfBirth, required this.gender, this.location});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'location': location?.toJson(),
    };
  }
}

class Location {
  final String district;
  final String area;
  final String unit;

  Location({required this.district, required this.area, required this.unit});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      district: json['district'] ?? '',
      area: json['area'] ?? '',
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'district': district, 'area': area, 'unit': unit};
  }
}
