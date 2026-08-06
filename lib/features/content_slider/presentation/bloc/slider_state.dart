import 'package:equatable/equatable.dart';
import '../../domain/entities/slider_entity.dart';

abstract class SliderState extends Equatable {
  const SliderState();
  
  @override
  List<Object?> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<SliderEntity> sliders;

  const SliderLoaded(this.sliders);

  @override
  List<Object?> get props => [sliders];
}

class SliderActionInProgress extends SliderState {
  final List<SliderEntity> sliders;

  const SliderActionInProgress(this.sliders);

  @override
  List<Object?> get props => [sliders];
}

class SliderActionSuccess extends SliderState {
  final String message;

  const SliderActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SliderError extends SliderState {
  final String message;

  const SliderError(this.message);

  @override
  List<Object?> get props => [message];
}
