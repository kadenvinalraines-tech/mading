import 'package:equatable/equatable.dart';

class ApprovalEntity extends Equatable {
  final String id;
  final String title;
  final String mediaUrl;
  final String mediaType;
  final String submittedBy;
  final DateTime submittedAt;
  final String status;
  final String? notes;

  const ApprovalEntity({
    required this.id,
    required this.title,
    required this.mediaUrl,
    required this.mediaType,
    required this.submittedBy,
    required this.submittedAt,
    required this.status,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        mediaUrl,
        mediaType,
        submittedBy,
        submittedAt,
        status,
        notes,
      ];
}
