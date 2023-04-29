class AuthUserModel {
  AuthUserModel({
    required this.message,
    required this.userId,
    required this.csrfToken,
  });

  final String message;
  final int userId;
  final String csrfToken;

  factory AuthUserModel.fromMap(Map<String, dynamic> json) => AuthUserModel(
        message: json["message"],
        userId: json["user_id"],
        csrfToken: json["csrf_token"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user_id": userId,
        "csrf_token": csrfToken,
      };
}

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.phoneNumber,
    required this.image,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String location;
  final String phoneNumber;
  final dynamic image;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        location: json["location"],
        phoneNumber: json["phone_number"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "location": location,
        "phone_number": phoneNumber,
        "image": image,
      };
}

class UserDetailModel {
  final int id;
  final String password;
  final DateTime lastLogin;
  final bool isSuperuser;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool isStaff;
  final bool isActive;
  final DateTime dateJoined;
  final String location;
  final String phoneNumber;
  final dynamic image;
  final List<dynamic> groups;
  final List<dynamic> userPermissions;

  UserDetailModel({
    required this.id,
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.location,
    required this.phoneNumber,
    required this.image,
    required this.groups,
    required this.userPermissions,
  });

  factory UserDetailModel.fromMap(Map<String, dynamic> json) => UserDetailModel(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        location: json["location"],
        phoneNumber: json["phone_number"],
        image: json["image"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "location": location,
        "phone_number": phoneNumber,
        "image": image,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
