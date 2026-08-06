import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/slider_entity.dart';
import '../repositories/slider_repository.dart';

@lazySingleton
class GetSlidersUseCase {
  final SliderRepository repository;

  GetSlidersUseCase(this.repository);

  Future<Either<Failure, List<SliderEntity>>> call() {
    return repository.getSliders();
  }
}
