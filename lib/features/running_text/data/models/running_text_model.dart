import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/running_text_entity.dart';

part 'running_text_model.g.dart';

@JsonSerializable()
class RunningTextModel extends RunningTextEntity {
  const RunningTextModel({
    required super.id,
    required super.text,
    super.isActive = true,
    required super.createdAt,
  });

  factory RunningTextModel.fromJson(Map<String, dynamic> json) =>
      _$RunningTextModelFromJson(json);

  Map<String, dynamic> toJson() => _$RunningTextModelToJson(this);

  RunningTextEntity toEntity() {
    return RunningTextEntity(
      id: id,
      text: text,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
