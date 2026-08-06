import 'package:equatable/equatable.dart';

class RunningTextEntity extends Equatable {
  final String id;
  final String text;
  final bool isActive;
  final DateTime createdAt;

  const RunningTextEntity({
    required this.id,
    required this.text,
    this.isActive = true,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        isActive,
        createdAt,
      ];
}
