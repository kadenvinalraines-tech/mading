import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/running_text_entity.dart';

abstract class RunningTextRepository {
  Future<Either<Failure, List<RunningTextEntity>>> getRunningTexts();

  Future<Either<Failure, RunningTextEntity>> addRunningText(String text);

  Future<Either<Failure, void>> deleteRunningText(String id);
}
