import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final String id;
  final String title;
  final String mediaUrl;
  final String mediaType;
  final int durationSeconds;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  const SliderEntity({
    required this.id,
    required this.title,
    required this.mediaUrl,
    required this.mediaType,
    required this.durationSeconds,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        mediaUrl,
        mediaType,
        durationSeconds,
        startDate,
        endDate,
        status,
      ];
}
