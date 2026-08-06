import 'package:equatable/equatable.dart';

abstract class RunningTextEvent extends Equatable {
  const RunningTextEvent();

  @override
  List<Object?> get props => [];
}

class LoadRunningTexts extends RunningTextEvent {
  const LoadRunningTexts();
}

class AddRunningTextSubmitted extends RunningTextEvent {
  final String text;

  const AddRunningTextSubmitted({required this.text});

  @override
  List<Object?> get props => [text];
}

class DeleteRunningTextSubmitted extends RunningTextEvent {
  final String id;

  const DeleteRunningTextSubmitted({required this.id});

  @override
  List<Object?> get props => [id];
}
