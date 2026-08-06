// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/approval/data/datasources/approval_remote_data_source.dart'
    as _i715;
import '../../features/approval/data/repositories/approval_repository_impl.dart'
    as _i1054;
import '../../features/approval/domain/repositories/approval_repository.dart'
    as _i551;
import '../../features/approval/domain/usecases/approve_content_usecase.dart'
    as _i68;
import '../../features/approval/domain/usecases/get_pending_approvals_usecase.dart'
    as _i666;
import '../../features/approval/domain/usecases/reject_content_usecase.dart'
    as _i679;
import '../../features/approval/presentation/bloc/approval_bloc.dart' as _i51;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/content_slider/data/datasources/slider_remote_data_source.dart'
    as _i67;
import '../../features/content_slider/data/repositories/slider_repository_impl.dart'
    as _i686;
import '../../features/content_slider/domain/repositories/slider_repository.dart'
    as _i727;
import '../../features/content_slider/domain/usecases/delete_slider_usecase.dart'
    as _i50;
import '../../features/content_slider/domain/usecases/get_sliders_usecase.dart'
    as _i967;
import '../../features/content_slider/domain/usecases/upload_slider_usecase.dart'
    as _i557;
import '../../features/content_slider/presentation/bloc/slider_bloc.dart'
    as _i753;
import '../../features/running_text/data/datasources/running_text_remote_data_source.dart'
    as _i104;
import '../../features/running_text/data/repositories/running_text_repository_impl.dart'
    as _i824;
import '../../features/running_text/domain/repositories/running_text_repository.dart'
    as _i331;
import '../../features/running_text/domain/usecases/running_text_usecases.dart'
    as _i441;
import '../../features/running_text/presentation/bloc/running_text_bloc.dart'
    as _i103;
import '../network/auth_interceptor.dart' as _i908;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage,
    );
    gh.lazySingleton<_i908.AuthInterceptor>(
      () => _i908.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i852.AuthLocalDataSource>(
      () => _i852.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i908.AuthInterceptor>()),
    );
    gh.lazySingleton<_i104.RunningTextRemoteDataSource>(
      () => _i104.RunningTextRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i715.ApprovalRemoteDataSource>(
      () => _i715.ApprovalRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i67.SliderRemoteDataSource>(
      () => _i67.SliderRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i727.SliderRepository>(
      () => _i686.SliderRepositoryImpl(gh<_i67.SliderRemoteDataSource>()),
    );
    gh.lazySingleton<_i331.RunningTextRepository>(
      () => _i824.RunningTextRepositoryImpl(
        gh<_i104.RunningTextRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i441.GetRunningTextsUseCase>(
      () => _i441.GetRunningTextsUseCase(gh<_i331.RunningTextRepository>()),
    );
    gh.lazySingleton<_i441.AddRunningTextUseCase>(
      () => _i441.AddRunningTextUseCase(gh<_i331.RunningTextRepository>()),
    );
    gh.lazySingleton<_i441.DeleteRunningTextUseCase>(
      () => _i441.DeleteRunningTextUseCase(gh<_i331.RunningTextRepository>()),
    );
    gh.lazySingleton<_i551.ApprovalRepository>(
      () => _i1054.ApprovalRepositoryImpl(gh<_i715.ApprovalRemoteDataSource>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i107.AuthRemoteDataSource>(),
        localDataSource: gh<_i852.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i103.RunningTextBloc>(
      () => _i103.RunningTextBloc(
        gh<_i441.GetRunningTextsUseCase>(),
        gh<_i441.AddRunningTextUseCase>(),
        gh<_i441.DeleteRunningTextUseCase>(),
      ),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i68.ApproveContentUseCase>(
      () => _i68.ApproveContentUseCase(gh<_i551.ApprovalRepository>()),
    );
    gh.lazySingleton<_i666.GetPendingApprovalsUseCase>(
      () => _i666.GetPendingApprovalsUseCase(gh<_i551.ApprovalRepository>()),
    );
    gh.lazySingleton<_i679.RejectContentUseCase>(
      () => _i679.RejectContentUseCase(gh<_i551.ApprovalRepository>()),
    );
    gh.lazySingleton<_i50.DeleteSliderUseCase>(
      () => _i50.DeleteSliderUseCase(gh<_i727.SliderRepository>()),
    );
    gh.lazySingleton<_i967.GetSlidersUseCase>(
      () => _i967.GetSlidersUseCase(gh<_i727.SliderRepository>()),
    );
    gh.lazySingleton<_i557.UploadSliderUseCase>(
      () => _i557.UploadSliderUseCase(gh<_i727.SliderRepository>()),
    );
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(gh<_i188.LoginUseCase>()));
    gh.factory<_i51.ApprovalBloc>(
      () => _i51.ApprovalBloc(
        gh<_i666.GetPendingApprovalsUseCase>(),
        gh<_i68.ApproveContentUseCase>(),
        gh<_i679.RejectContentUseCase>(),
      ),
    );
    gh.factory<_i753.SliderBloc>(
      () => _i753.SliderBloc(
        gh<_i967.GetSlidersUseCase>(),
        gh<_i557.UploadSliderUseCase>(),
        gh<_i50.DeleteSliderUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
