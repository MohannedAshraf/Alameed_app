import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/complete_onboarding_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(this._completeOnboardingUseCase)
    : super(const OnboardingInitial()) {
    on<OnboardingSkipRequested>(_onComplete);
    on<OnboardingFinishRequested>(_onComplete);
  }

  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  Future<void> _onComplete(
    OnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    await _completeOnboardingUseCase();
    emit(const OnboardingCompleted());
  }
}
