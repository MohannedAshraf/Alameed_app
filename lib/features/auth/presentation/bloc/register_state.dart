import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess(this.user);
  final UserEntity user;
  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends RegisterState {
  const RegisterFailure(this.messageKey);
  final String messageKey;
  @override
  List<Object?> get props => [messageKey];
}
