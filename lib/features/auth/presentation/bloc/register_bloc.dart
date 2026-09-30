import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_exception.dart';
import '../../domain/usecases/register_with_email_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._registerWithEmailUseCase)
    : super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  final RegisterWithEmailUseCase _registerWithEmailUseCase;

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());
    try {
      final user = await _registerWithEmailUseCase(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(RegisterSuccess(user));
    } on ApiException catch (e) {
      emit(RegisterFailure(e.messageKey));
    } catch (_) {
      emit(const RegisterFailure('common.something_went_wrong'));
    }
  }
}
