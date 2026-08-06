// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalModel _$ApprovalModelFromJson(Map<String, dynamic> json) =>
    ApprovalModel(
      id: json['id'] as String,
      title: json['title'] as String,
      mediaUrl: json['mediaUrl'] as String,
      mediaType: json['mediaType'] as String,
      submittedBy: json['submittedBy'] as String,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ApprovalModelToJson(ApprovalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
      'submittedBy': instance.submittedBy,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
    };
