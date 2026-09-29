import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped "Skip" — jump straight to login without seeing the rest.
class OnboardingSkipRequested extends OnboardingEvent {
  const OnboardingSkipRequested();
}

/// User tapped "Get started" on the last page.
class OnboardingFinishRequested extends OnboardingEvent {
  const OnboardingFinishRequested();
}
