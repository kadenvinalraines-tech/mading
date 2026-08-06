// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'running_text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunningTextModel _$RunningTextModelFromJson(Map<String, dynamic> json) =>
    RunningTextModel(
      id: json['id'] as String,
      text: json['text'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RunningTextModelToJson(RunningTextModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
