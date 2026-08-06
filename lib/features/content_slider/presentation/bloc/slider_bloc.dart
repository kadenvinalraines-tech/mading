import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/slider_entity.dart';
import '../../domain/usecases/delete_slider_usecase.dart';
import '../../domain/usecases/get_sliders_usecase.dart';
import '../../domain/usecases/upload_slider_usecase.dart';
import 'slider_event.dart';
import 'slider_state.dart';

@injectable
class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final GetSlidersUseCase _getSlidersUseCase;
  final UploadSliderUseCase _uploadSliderUseCase;
  final DeleteSliderUseCase _deleteSliderUseCase;

  SliderBloc(
    this._getSlidersUseCase,
    this._uploadSliderUseCase,
    this._deleteSliderUseCase,
  ) : super(SliderInitial()) {
    on<LoadSliders>(_onLoadSliders);
    on<UploadSliderSubmitted>(_onUploadSliderSubmitted);
    on<DeleteSliderSubmitted>(_onDeleteSliderSubmitted);
  }

  List<SliderEntity> _getCurrentSliders() {
    if (state is SliderLoaded) {
      return (state as SliderLoaded).sliders;
    } else if (state is SliderActionInProgress) {
      return (state as SliderActionInProgress).sliders;
    }
    return [];
  }

  Future<void> _onLoadSliders(
    LoadSliders event,
    Emitter<SliderState> emit,
  ) async {
    emit(SliderLoading());

    final result = await _getSlidersUseCase();

    result.fold(
      (failure) => emit(SliderError(failure.message)),
      (sliders) => emit(SliderLoaded(sliders)),
    );
  }

  Future<void> _onUploadSliderSubmitted(
    UploadSliderSubmitted event,
    Emitter<SliderState> emit,
  ) async {
    emit(SliderActionInProgress(_getCurrentSliders()));

    final result = await _uploadSliderUseCase(
      title: event.title,
      filePath: event.filePath,
      mediaType: event.mediaType,
      durationSeconds: event.durationSeconds,
      startDate: event.startDate,
      endDate: event.endDate,
    );

    result.fold(
      (failure) => emit(SliderError(failure.message)),
      (_) {
        emit(const SliderActionSuccess('Konten berhasil diunggah!'));
        add(const LoadSliders());
      },
    );
  }

  Future<void> _onDeleteSliderSubmitted(
    DeleteSliderSubmitted event,
    Emitter<SliderState> emit,
  ) async {
    emit(SliderActionInProgress(_getCurrentSliders()));

    final result = await _deleteSliderUseCase(event.id);

    result.fold(
      (failure) => emit(SliderError(failure.message)),
      (_) {
        emit(const SliderActionSuccess('Konten berhasil dihapus!'));
        add(const LoadSliders());
      },
    );
  }
}
