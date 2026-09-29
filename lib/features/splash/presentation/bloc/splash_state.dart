import 'package:equatable/equatable.dart';

enum SplashDestination { onboarding, login }

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

/// Emitted once the splash timer + the onboarding check are both done.
/// The screen listens for this and navigates accordingly.
class SplashFinished extends SplashState {
  const SplashFinished(this.destination);

  final SplashDestination destination;

  @override
  List<Object?> get props => [destination];
}
