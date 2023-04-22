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
