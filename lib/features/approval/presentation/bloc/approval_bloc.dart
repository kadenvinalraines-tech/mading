import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/approval_entity.dart';
import '../../domain/usecases/approve_content_usecase.dart';
import '../../domain/usecases/get_pending_approvals_usecase.dart';
import '../../domain/usecases/reject_content_usecase.dart';
import 'approval_event.dart';
import 'approval_state.dart';

@injectable
class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState> {
  final GetPendingApprovalsUseCase _getPendingApprovalsUseCase;
  final ApproveContentUseCase _approveContentUseCase;
  final RejectContentUseCase _rejectContentUseCase;

  ApprovalBloc(
    this._getPendingApprovalsUseCase,
    this._approveContentUseCase,
    this._rejectContentUseCase,
  ) : super(ApprovalInitial()) {
    on<LoadPendingApprovals>(_onLoadPendingApprovals);
    on<ApproveContentSubmitted>(_onApproveContentSubmitted);
    on<RejectContentSubmitted>(_onRejectContentSubmitted);
  }

  List<ApprovalEntity> _getCurrentApprovals() {
    if (state is ApprovalLoaded) {
      return (state as ApprovalLoaded).approvals;
    } else if (state is ApprovalActionInProgress) {
      return (state as ApprovalActionInProgress).approvals;
    }
    return [];
  }

  Future<void> _onLoadPendingApprovals(
    LoadPendingApprovals event,
    Emitter<ApprovalState> emit,
  ) async {
    emit(ApprovalLoading());

    final result = await _getPendingApprovalsUseCase();

    result.fold(
      (failure) => emit(ApprovalError(failure.message)),
      (approvals) => emit(ApprovalLoaded(approvals)),
    );
  }

  Future<void> _onApproveContentSubmitted(
    ApproveContentSubmitted event,
    Emitter<ApprovalState> emit,
  ) async {
    emit(ApprovalActionInProgress(_getCurrentApprovals()));

    final result = await _approveContentUseCase(event.contentId);

    result.fold(
      (failure) => emit(ApprovalError(failure.message)),
      (_) {
        emit(const ApprovalActionSuccess('Konten berhasil disetujui dan akan tayang.'));
        add(LoadPendingApprovals());
      },
    );
  }

  Future<void> _onRejectContentSubmitted(
    RejectContentSubmitted event,
    Emitter<ApprovalState> emit,
  ) async {
    emit(ApprovalActionInProgress(_getCurrentApprovals()));

    final result = await _rejectContentUseCase(event.contentId, event.reason);

    result.fold(
      (failure) => emit(ApprovalError(failure.message)),
      (_) {
        emit(const ApprovalActionSuccess('Konten dikembalikan ke draf OSIS.'));
        add(LoadPendingApprovals());
      },
    );
  }
}
