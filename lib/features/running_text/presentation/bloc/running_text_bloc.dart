import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/running_text_usecases.dart';
import 'running_text_event.dart';
import 'running_text_state.dart';

@injectable
class RunningTextBloc extends Bloc<RunningTextEvent, RunningTextState> {
  final GetRunningTextsUseCase _getRunningTextsUseCase;
  final AddRunningTextUseCase _addRunningTextUseCase;
  final DeleteRunningTextUseCase _deleteRunningTextUseCase;

  RunningTextBloc(
    this._getRunningTextsUseCase,
    this._addRunningTextUseCase,
    this._deleteRunningTextUseCase,
  ) : super(const RunningTextInitial()) {
    on<LoadRunningTexts>(_onLoadRunningTexts);
    on<AddRunningTextSubmitted>(_onAddRunningTextSubmitted);
    on<DeleteRunningTextSubmitted>(_onDeleteRunningTextSubmitted);
  }

  Future<void> _onLoadRunningTexts(
    LoadRunningTexts event,
    Emitter<RunningTextState> emit,
  ) async {
    emit(const RunningTextLoading());
    final result = await _getRunningTextsUseCase();

    result.fold(
      (failure) => emit(RunningTextError(failure.message)),
      (runningTexts) => emit(RunningTextLoaded(runningTexts)),
    );
  }

  Future<void> _onAddRunningTextSubmitted(
    AddRunningTextSubmitted event,
    Emitter<RunningTextState> emit,
  ) async {
    emit(const RunningTextActionInProgress());
    final result = await _addRunningTextUseCase(event.text);

    result.fold(
      (failure) => emit(RunningTextError(failure.message)),
      (_) {
        emit(const RunningTextActionSuccess('Teks berjalan berhasil ditambahkan.'));
        add(const LoadRunningTexts());
      },
    );
  }

  Future<void> _onDeleteRunningTextSubmitted(
    DeleteRunningTextSubmitted event,
    Emitter<RunningTextState> emit,
  ) async {
    emit(const RunningTextActionInProgress());
    final result = await _deleteRunningTextUseCase(event.id);

    result.fold(
      (failure) => emit(RunningTextError(failure.message)),
      (_) {
        emit(const RunningTextActionSuccess('Teks berjalan berhasil dihapus.'));
        add(const LoadRunningTexts());
      },
    );
  }
}
