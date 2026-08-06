import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/approval_model.dart';

abstract class ApprovalRemoteDataSource {
  Future<List<ApprovalModel>> getPendingApprovals();
  Future<ApprovalModel> approveContent(String contentId);
  Future<ApprovalModel> rejectContent(String contentId, String reason);
}

@LazySingleton(as: ApprovalRemoteDataSource)
class ApprovalRemoteDataSourceImpl implements ApprovalRemoteDataSource {
  final Dio _dio;

  ApprovalRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ApprovalModel>> getPendingApprovals() async {
    try {
      final response = await _dio.get('/approvals/pending');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List;
        return data.map((e) => ApprovalModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal mengambil data approval');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ApprovalModel> approveContent(String contentId) async {
    try {
      final response = await _dio.put('/approvals/$contentId/approve');
      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApprovalModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal menyetujui konten');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ApprovalModel> rejectContent(String contentId, String reason) async {
    try {
      final response = await _dio.put(
        '/approvals/$contentId/reject',
        data: {'reason': reason},
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApprovalModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal menolak konten');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
