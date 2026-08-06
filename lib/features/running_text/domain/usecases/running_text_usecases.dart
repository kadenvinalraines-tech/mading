import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/running_text_entity.dart';
import '../repositories/running_text_repository.dart';

@lazySingleton
class GetRunningTextsUseCase {
  final RunningTextRepository repository;

  GetRunningTextsUseCase(this.repository);

  Future<Either<Failure, List<RunningTextEntity>>> call() {
    return repository.getRunningTexts();
  }
}

@lazySingleton
class AddRunningTextUseCase {
  final RunningTextRepository repository;

  AddRunningTextUseCase(this.repository);

  Future<Either<Failure, RunningTextEntity>> call(String text) async {
    if (text.trim().isEmpty) {
      return const Left(ServerFailure('Teks pengumuman tidak boleh kosong.'));
    }
    return repository.addRunningText(text);
  }
}

@lazySingleton
class DeleteRunningTextUseCase {
  final RunningTextRepository repository;

  DeleteRunningTextUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteRunningText(id);
  }
}
