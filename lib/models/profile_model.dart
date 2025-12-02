class UserProfileModel {
  final bool? success;
  final UserData? data;

  UserProfileModel({this.success, this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final User? user;

  UserData({this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String? id;
  final String? name;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final Profile? profile;

  User({
    this.id,
    this.name,
    this.phone,
    this.role,
    this.isVerified,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
      isVerified: json['isVerified'],
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'])
          : null,
    );
  }
}

class Profile {
  final String? dateOfBirth;
  final String? gender;
  final Location? location;

  Profile({this.dateOfBirth, this.gender, this.location});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
    );
  }
}

class Location {
  final String? district;
  final String? area;
  final String? unit;

  Location({this.district, this.area, this.unit});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      district: json['district'],
      area: json['area'],
      unit: json['unit'],
    );
  }
}
