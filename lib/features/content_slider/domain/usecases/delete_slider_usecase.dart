import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/slider_repository.dart';

@lazySingleton
class DeleteSliderUseCase {
  final SliderRepository repository;

  DeleteSliderUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteSlider(id);
  }
}
