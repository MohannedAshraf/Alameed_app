import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Email/password, Google, or Apple all succeed the same way — a logged-in user.
class LoginSuccess extends LoginState {
  const LoginSuccess(this.user);
  final UserEntity user;
  @override
  List<Object?> get props => [user];
}

/// OTP sent for the phone flow — screen navigates to OtpScreen with this phone.
class LoginOtpSent extends LoginState {
  const LoginOtpSent(this.phone);
  final String phone;
  @override
  List<Object?> get props => [phone];
}

class LoginFailure extends LoginState {
  const LoginFailure(this.messageKey);
  final String messageKey;
  @override
  List<Object?> get props => [messageKey];
}
