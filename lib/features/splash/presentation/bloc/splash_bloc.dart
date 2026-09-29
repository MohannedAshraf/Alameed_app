import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_onboarding_seen_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._getOnboardingSeenUseCase) : super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  final GetOnboardingSeenUseCase _getOnboardingSeenUseCase;

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    // Keep the logo on screen for a fixed, deliberate moment (max 5s per
    // spec) instead of navigating the instant the check finishes — a
    // splash that flashes for 40ms looks like a bug, not a brand moment.
    await Future.delayed(AppDurations.splashDuration);

    final hasSeenOnboarding = _getOnboardingSeenUseCase();

    emit(
      SplashFinished(
        hasSeenOnboarding
            ? SplashDestination.login
            : SplashDestination.onboarding,
      ),
    );
  }
}
