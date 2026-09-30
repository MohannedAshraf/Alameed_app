import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'].toString(),
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    phone: json['phone'] as String? ?? '',
    avatarUrl: json['avatar_url'] as String?,
  );
}

/// Wraps a login/register response: the user profile + the auth token.
/// Stays in the data layer on purpose — domain/presentation only ever see
/// UserEntity; the token is handled internally by AuthRepositoryImpl.
class AuthResponseModel {
  const AuthResponseModel({required this.user, required this.token});

  final UserModel user;
  final String token;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String? ?? '',
      );
}
