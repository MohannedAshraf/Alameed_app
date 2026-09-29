import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// The "seen" flag is saved — the screen listens for this and navigates
/// to login.
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
