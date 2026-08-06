import 'package:equatable/equatable.dart';

import '../../domain/entities/running_text_entity.dart';

abstract class RunningTextState extends Equatable {
  const RunningTextState();

  @override
  List<Object?> get props => [];
}

class RunningTextInitial extends RunningTextState {
  const RunningTextInitial();
}

class RunningTextLoading extends RunningTextState {
  const RunningTextLoading();
}

class RunningTextLoaded extends RunningTextState {
  final List<RunningTextEntity> runningTexts;

  const RunningTextLoaded(this.runningTexts);

  @override
  List<Object?> get props => [runningTexts];
}

class RunningTextActionInProgress extends RunningTextState {
  const RunningTextActionInProgress();
}

class RunningTextActionSuccess extends RunningTextState {
  final String message;

  const RunningTextActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RunningTextError extends RunningTextState {
  final String message;

  const RunningTextError(this.message);

  @override
  List<Object?> get props => [message];
}
