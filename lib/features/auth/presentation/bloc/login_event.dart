import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginWithEmailSubmitted extends LoginEvent {
  const LoginWithEmailSubmitted({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class LoginSendOtpSubmitted extends LoginEvent {
  const LoginSendOtpSubmitted({required this.phone});
  final String phone;
  @override
  List<Object?> get props => [phone];
}

class LoginWithGoogleRequested extends LoginEvent {
  const LoginWithGoogleRequested();
}

class LoginWithAppleRequested extends LoginEvent {
  const LoginWithAppleRequested();
}
