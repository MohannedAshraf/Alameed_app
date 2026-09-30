import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_exception.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(this._verifyOtpUseCase, this._sendOtpUseCase)
    : super(const OtpInitial()) {
    on<OtpVerifySubmitted>(_onVerify);
    on<OtpResendRequested>(_onResend);
  }

  final VerifyOtpUseCase _verifyOtpUseCase;
  final SendOtpUseCase _sendOtpUseCase;

  Future<void> _onVerify(
    OtpVerifySubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpVerifying());
    try {
      final user = await _verifyOtpUseCase(phone: event.phone, otp: event.otp);
      emit(OtpVerifySuccess(user));
    } on ApiException catch (e) {
      emit(OtpFailure(e.messageKey));
    } catch (_) {
      emit(const OtpFailure('common.something_went_wrong'));
    }
  }

  Future<void> _onResend(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpResending());
    try {
      await _sendOtpUseCase(phone: event.phone);
      emit(const OtpResendSuccess());
    } on ApiException catch (e) {
      emit(OtpFailure(e.messageKey));
    } catch (_) {
      emit(const OtpFailure('common.something_went_wrong'));
    }
  }
}
