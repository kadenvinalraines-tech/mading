// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
  id: json['id'] as String,
  title: json['title'] as String,
  mediaUrl: json['mediaUrl'] as String,
  mediaType: json['mediaType'] as String,
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  status: json['status'] as String,
);

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
      'durationSeconds': instance.durationSeconds,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': instance.status,
    };
