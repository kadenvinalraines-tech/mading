import 'package:equatable/equatable.dart';

abstract class ApprovalEvent extends Equatable {
  const ApprovalEvent();

  @override
  List<Object?> get props => [];
}

class LoadPendingApprovals extends ApprovalEvent {}

class ApproveContentSubmitted extends ApprovalEvent {
  final String contentId;

  const ApproveContentSubmitted({required this.contentId});

  @override
  List<Object?> get props => [contentId];
}

class RejectContentSubmitted extends ApprovalEvent {
  final String contentId;
  final String reason;

  const RejectContentSubmitted({
    required this.contentId,
    required this.reason,
  });

  @override
  List<Object?> get props => [contentId, reason];
}
