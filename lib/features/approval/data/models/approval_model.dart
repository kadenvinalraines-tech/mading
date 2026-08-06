import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/approval_entity.dart';

part 'approval_model.g.dart';

@JsonSerializable()
class ApprovalModel extends ApprovalEntity {
  const ApprovalModel({
    required super.id,
    required super.title,
    required super.mediaUrl,
    required super.mediaType,
    required super.submittedBy,
    required super.submittedAt,
    required super.status,
    super.notes,
  });

  factory ApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalModelToJson(this);

  ApprovalEntity toEntity() {
    return ApprovalEntity(
      id: id,
      title: title,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      submittedBy: submittedBy,
      submittedAt: submittedAt,
      status: status,
      notes: notes,
    );
  }
}
