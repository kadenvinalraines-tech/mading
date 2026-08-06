import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../models/slider_model.dart';

abstract class SliderRemoteDataSource {
  Future<List<SliderModel>> getSliders();
  
  Future<SliderModel> uploadSlider(FormData formData);
  
  Future<void> deleteSlider(String id);
}

@LazySingleton(as: SliderRemoteDataSource)
class SliderRemoteDataSourceImpl implements SliderRemoteDataSource {
  final Dio _dio;

  SliderRemoteDataSourceImpl(this._dio);

  @override
  Future<List<SliderModel>> getSliders() async {
    try {
      final response = await _dio.get('/sliders');
      
      if (response.statusCode == 200) {
        final data = (response.data['data'] != null) ? response.data['data'] as List : response.data as List;
        return data.map((e) => SliderModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal mengambil data slider');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<SliderModel> uploadSlider(FormData formData) async {
    try {
      final response = await _dio.post('/sliders', data: formData);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return SliderModel.fromJson(data);
      } else {
        throw ServerFailure(response.data['message'] ?? 'Gagal mengunggah slider');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteSlider(String id) async {
    try {
      final response = await _dio.delete('/sliders/$id');
      
      if (response.statusCode != 200) {
        throw ServerFailure(response.data['message'] ?? 'Gagal menghapus slider');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan jaringan');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
