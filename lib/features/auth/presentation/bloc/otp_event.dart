import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object?> get props => [];
}

class OtpVerifySubmitted extends OtpEvent {
  const OtpVerifySubmitted({required this.phone, required this.otp});
  final String phone;
  final String otp;
  @override
  List<Object?> get props => [phone, otp];
}

class OtpResendRequested extends OtpEvent {
  const OtpResendRequested({required this.phone});
  final String phone;
  @override
  List<Object?> get props => [phone];
}
