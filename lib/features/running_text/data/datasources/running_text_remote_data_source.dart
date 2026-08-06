import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../models/running_text_model.dart';

abstract class RunningTextRemoteDataSource {
  Future<List<RunningTextModel>> getRunningTexts();

  Future<RunningTextModel> addRunningText(String text);

  Future<void> deleteRunningText(String id);
}

@LazySingleton(as: RunningTextRemoteDataSource)
class RunningTextRemoteDataSourceImpl implements RunningTextRemoteDataSource {
  final Dio _dio;

  RunningTextRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RunningTextModel>> getRunningTexts() async {
    try {
      final response = await _dio.get('/running-texts');

      if (response.statusCode == 200) {
        final data = response.data['data'] != null
            ? response.data['data'] as List
            : response.data as List;
        return data.map((e) => RunningTextModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal mengambil data teks berjalan');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<RunningTextModel> addRunningText(String text) async {
    try {
      final response = await _dio.post(
        '/running-texts',
        data: {'text': text},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return RunningTextModel.fromJson(data);
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal menambahkan teks berjalan');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteRunningText(String id) async {
    try {
      final response = await _dio.delete('/running-texts/$id');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerFailure(response.data['message'] ?? 'Gagal menghapus teks berjalan');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
