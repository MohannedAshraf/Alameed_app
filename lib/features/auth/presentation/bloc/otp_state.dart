import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class OtpState extends Equatable {
  const OtpState();
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {
  const OtpInitial();
}

class OtpVerifying extends OtpState {
  const OtpVerifying();
}

class OtpVerifySuccess extends OtpState {
  const OtpVerifySuccess(this.user);
  final UserEntity user;
  @override
  List<Object?> get props => [user];
}

class OtpResending extends OtpState {
  const OtpResending();
}

class OtpResendSuccess extends OtpState {
  const OtpResendSuccess();
}

class OtpFailure extends OtpState {
  const OtpFailure(this.messageKey);
  final String messageKey;
  @override
  List<Object?> get props => [messageKey];
}
