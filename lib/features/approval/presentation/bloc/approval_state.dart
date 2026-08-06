import 'package:equatable/equatable.dart';
import '../../domain/entities/approval_entity.dart';

abstract class ApprovalState extends Equatable {
  const ApprovalState();
  
  @override
  List<Object?> get props => [];
}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class ApprovalLoaded extends ApprovalState {
  final List<ApprovalEntity> approvals;

  const ApprovalLoaded(this.approvals);

  @override
  List<Object?> get props => [approvals];
}

class ApprovalActionInProgress extends ApprovalState {
  final List<ApprovalEntity> approvals;

  const ApprovalActionInProgress(this.approvals);

  @override
  List<Object?> get props => [approvals];
}

class ApprovalActionSuccess extends ApprovalState {
  final String message;

  const ApprovalActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ApprovalError extends ApprovalState {
  final String message;

  const ApprovalError(this.message);

  @override
  List<Object?> get props => [message];
}
