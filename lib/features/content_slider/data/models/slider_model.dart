import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/slider_entity.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel extends SliderEntity {
  const SliderModel({
    required super.id,
    required super.title,
    required super.mediaUrl,
    required super.mediaType,
    required super.durationSeconds,
    required super.startDate,
    required super.endDate,
    required super.status,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);

  SliderEntity toEntity() {
    return SliderEntity(
      id: id,
      title: title,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      durationSeconds: durationSeconds,
      startDate: startDate,
      endDate: endDate,
      status: status,
    );
  }
}
