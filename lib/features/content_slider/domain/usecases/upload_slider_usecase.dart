import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/slider_entity.dart';
import '../repositories/slider_repository.dart';

@lazySingleton
class UploadSliderUseCase {
  final SliderRepository repository;

  UploadSliderUseCase(this.repository);

  Future<Either<Failure, SliderEntity>> call({
    required String title,
    required String filePath,
    required String mediaType,
    required int durationSeconds,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (filePath.trim().isEmpty) {
      return const Left(ServerFailure('File media harus dipilih.'));
    }

    return repository.uploadSlider(
      title: title,
      filePath: filePath,
      mediaType: mediaType,
      durationSeconds: durationSeconds,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
