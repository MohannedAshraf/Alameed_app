import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_exception.dart';
import '../../domain/usecases/login_with_apple_usecase.dart';
import '../../domain/usecases/login_with_email_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this._loginWithEmailUseCase,
    this._sendOtpUseCase,
    this._loginWithGoogleUseCase,
    this._loginWithAppleUseCase,
  ) : super(const LoginInitial()) {
    on<LoginWithEmailSubmitted>(_onLoginWithEmail);
    on<LoginSendOtpSubmitted>(_onSendOtp);
    on<LoginWithGoogleRequested>(_onLoginWithGoogle);
    on<LoginWithAppleRequested>(_onLoginWithApple);
  }

  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginWithAppleUseCase _loginWithAppleUseCase;

  Future<void> _onLoginWithEmail(
    LoginWithEmailSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final user = await _loginWithEmailUseCase(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(user));
    } on ApiException catch (e) {
      emit(LoginFailure(e.messageKey));
    } catch (_) {
      emit(const LoginFailure('common.something_went_wrong'));
    }
  }

  Future<void> _onSendOtp(
    LoginSendOtpSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      await _sendOtpUseCase(phone: event.phone);
      emit(LoginOtpSent(event.phone));
    } on ApiException catch (e) {
      emit(LoginFailure(e.messageKey));
    } catch (_) {
      emit(const LoginFailure('common.something_went_wrong'));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final user = await _loginWithGoogleUseCase();
      emit(LoginSuccess(user));
    } on ApiException catch (e) {
      emit(LoginFailure(e.messageKey));
    } catch (_) {
      emit(const LoginFailure('common.something_went_wrong'));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final user = await _loginWithAppleUseCase();
      emit(LoginSuccess(user));
    } on ApiException catch (e) {
      emit(LoginFailure(e.messageKey));
    } catch (_) {
      emit(const LoginFailure('common.something_went_wrong'));
    }
  }
}
