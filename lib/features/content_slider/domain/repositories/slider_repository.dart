import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/slider_entity.dart';

abstract class SliderRepository {
  Future<Either<Failure, List<SliderEntity>>> getSliders();
  
  Future<Either<Failure, SliderEntity>> uploadSlider({
    required String title,
    required String filePath,
    required String mediaType,
    required int durationSeconds,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  Future<Either<Failure, void>> deleteSlider(String id);
}
