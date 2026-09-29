import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once by the splash screen right when it opens.
class SplashStarted extends SplashEvent {
  const SplashStarted();
}
