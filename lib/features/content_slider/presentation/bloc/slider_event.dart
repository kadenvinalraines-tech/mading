import 'package:equatable/equatable.dart';

abstract class SliderEvent extends Equatable {
  const SliderEvent();

  @override
  List<Object?> get props => [];
}

class LoadSliders extends SliderEvent {
  const LoadSliders();
}

class UploadSliderSubmitted extends SliderEvent {
  final String title;
  final String filePath;
  final String mediaType;
  final int durationSeconds;
  final DateTime startDate;
  final DateTime endDate;

  const UploadSliderSubmitted({
    required this.title,
    required this.filePath,
    required this.mediaType,
    required this.durationSeconds,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
        title,
        filePath,
        mediaType,
        durationSeconds,
        startDate,
        endDate,
      ];
}

class DeleteSliderSubmitted extends SliderEvent {
  final String id;

  const DeleteSliderSubmitted({required this.id});

  @override
  List<Object?> get props => [id];
}
