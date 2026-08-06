# Graph Report - .  (2026-08-06)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 470 nodes · 704 edges · 35 communities (29 shown, 6 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Win32Window
- AppDelegate
- login_form.dart
- approval_bloc.dart
- AuthBloc
- my_application.cc
- approval_model.dart
- approval_entity.dart
- get_sliders_usecase.dart
- @LazySingleton
- _
- auth_repository_impl.dart
- ../../../../core/error/failures.dart
- wWinMain
- manifest.json
- env.dart
- approval_remote_data_source.dart
- auth_interceptor.dart
- auth_local_data_source.dart
- register_module.dart
- package:injectable/injectable.dart
- approval_repository_impl.dart
- failures.dart
- exceptions.dart
- package:fpdart/fpdart.dart
- RegisterPlugins
- MainActivity
- widget_test.dart
- baseUrl
- _Env
- String?

## God Nodes (most connected - your core abstractions)
1. `_` - 37 edges
2. `Win32Window` - 22 edges
3. `ApprovalBloc` - 18 edges
4. `AuthBloc` - 15 edges
5. `MessageHandler` - 12 edges
6. `FlutterWindow` - 10 edges
7. `Create` - 10 edges
8. `WndProc` - 10 edges
9. `ApprovalState` - 9 edges
10. `MessageHandler` - 9 edges

## Surprising Connections (you probably didn't know these)
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.h → windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `_` --references--> `AuthInterceptor`  [EXTRACTED]
  lib/core/di/injection.config.dart → lib/core/network/auth_interceptor.dart
- `_` --references--> `ApprovalRemoteDataSource`  [EXTRACTED]
  lib/core/di/injection.config.dart → lib/features/approval/data/datasources/approval_remote_data_source.dart

## Import Cycles
- None detected.

## Communities (35 total, 6 thin omitted)

### Community 0 - "Win32Window"
Cohesion: 0.07
Nodes (51): Point, RECT, Size, unique_ptr, DartProject, HWND, LPARAM, LRESULT (+43 more)

### Community 1 - "AppDelegate"
Cohesion: 0.06
Nodes (27): Any, Cocoa, Flutter, flutter_secure_storage_darwin, FlutterAppDelegate, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, FlutterMacOS (+19 more)

### Community 2 - "login_form.dart"
Cohesion: 0.06
Nodes (34): ../bloc/approval_bloc.dart, ../bloc/approval_event.dart, ../bloc/approval_state.dart, ../bloc/auth_bloc.dart, ../bloc/auth_event.dart, ../bloc/auth_state.dart, core/di/injection.dart, core/routes/app_router.dart (+26 more)

### Community 3 - "approval_bloc.dart"
Cohesion: 0.09
Nodes (34): approval_event.dart, approval_state.dart, ../../domain/usecases/approve_content_usecase.dart, ../../domain/usecases/get_pending_approvals_usecase.dart, ../../domain/usecases/reject_content_usecase.dart, ApprovalBloc, _approveContentUseCase, _getCurrentApprovals (+26 more)

### Community 4 - "AuthBloc"
Cohesion: 0.10
Nodes (27): @injectable, auth_event.dart, auth_state.dart, Bloc, ../../domain/usecases/login_usecase.dart, Equatable, AuthBloc, _loginUseCase (+19 more)

### Community 5 - "my_application.cc"
Cohesion: 0.09
Nodes (22): FlPluginRegistry, FlView, GApplication, gboolean, gchar, GObject, GtkApplication, fl_register_plugins() (+14 more)

### Community 6 - "approval_model.dart"
Cohesion: 0.10
Nodes (18): @JsonSerializable, ../../domain/entities/approval_entity.dart, ../../domain/entities/user_entity.dart, ApprovalModel, fromJson, toEntity, toJson, ApprovalEntity (+10 more)

### Community 7 - "approval_entity.dart"
Cohesion: 0.10
Nodes (19): DateTime, id, mediaType, mediaUrl, notes, props, status, submittedAt (+11 more)

### Community 8 - "get_sliders_usecase.dart"
Cohesion: 0.14
Nodes (14): ../entities/slider_entity.dart, deleteSlider, getSliders, SliderRepository, uploadSlider, call, DeleteSliderUseCase, repository (+6 more)

### Community 9 - "@LazySingleton"
Cohesion: 0.15
Nodes (16): @LazySingleton, ../entities/approval_entity.dart, dio, ApprovalRepositoryImpl, ApprovalRepository, ApproveContentUseCase, call, repository (+8 more)

### Community 10 - "_"
Cohesion: 0.12
Nodes (18): ../../features/approval/data/datasources/approval_remote_data_source.dart, ../../features/approval/data/repositories/approval_repository_impl.dart, ../../features/approval/domain/repositories/approval_repository.dart, ../../features/approval/domain/usecases/approve_content_usecase.dart, ../../features/approval/domain/usecases/get_pending_approvals_usecase.dart, ../../features/approval/domain/usecases/reject_content_usecase.dart, ../../features/approval/presentation/bloc/approval_bloc.dart, ../../features/auth/data/datasources/auth_local_data_source.dart (+10 more)

### Community 11 - "auth_repository_impl.dart"
Cohesion: 0.15
Nodes (13): ../../../../core/error/exceptions.dart, ../datasources/auth_local_data_source.dart, ../datasources/auth_remote_data_source.dart, ../../domain/repositories/auth_repository.dart, AuthRemoteDataSource, AuthRemoteDataSourceImpl, dio, login (+5 more)

### Community 12 - "../../../../core/error/failures.dart"
Cohesion: 0.20
Nodes (10): ../../../../core/error/failures.dart, ../entities/user_entity.dart, AuthRepositoryImpl, AuthRepository, login, logout, call, LoginUseCase (+2 more)

### Community 13 - "wWinMain"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 14 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 15 - "env.dart"
Cohesion: 0.22
Nodes (8): @Envied, _envieddatabaseUrl, _enviedkeybaseUrl, baseUrl, Env, package:envied/envied.dart, static const List, static final String

### Community 16 - "approval_remote_data_source.dart"
Cohesion: 0.25
Nodes (8): Dio, ApprovalRemoteDataSource, ApprovalRemoteDataSourceImpl, approveContent, _dio, getPendingApprovals, rejectContent, ../models/approval_model.dart

### Community 17 - "auth_interceptor.dart"
Cohesion: 0.22
Nodes (8): FlutterSecureStorage, Interceptor, AuthInterceptor, _authTokenKey, onError, onRequest, _secureStorage, package:flutter_secure_storage/flutter_secure_storage.dart

### Community 18 - "auth_local_data_source.dart"
Cohesion: 0.25
Nodes (8): AuthLocalDataSource, AuthLocalDataSourceImpl, _authTokenKey, clearToken, getToken, saveToken, _secureStorage, static const String

### Community 19 - "register_module.dart"
Cohesion: 0.25
Nodes (7): @module, ../config/env.dart, FlutterSecureStorage get, flutterSecureStorage, RegisterModule, ../network/auth_interceptor.dart, package:dio/dio.dart

### Community 20 - "package:injectable/injectable.dart"
Cohesion: 0.29
Nodes (6): @InjectableInit, injection.config.dart, configureDependencies, locator, package:get_it/get_it.dart, package:injectable/injectable.dart

### Community 21 - "approval_repository_impl.dart"
Cohesion: 0.29
Nodes (6): ../datasources/approval_remote_data_source.dart, ../../domain/repositories/approval_repository.dart, approveContent, getPendingApprovals, rejectContent, _remoteDataSource

### Community 22 - "failures.dart"
Cohesion: 0.53
Nodes (5): AuthFailure, CacheFailure, Failure, message, ServerFailure

### Community 23 - "exceptions.dart"
Cohesion: 0.50
Nodes (4): Exception, CacheException, message, ServerException

### Community 24 - "package:fpdart/fpdart.dart"
Cohesion: 0.40
Nodes (4): approveContent, getPendingApprovals, rejectContent, package:fpdart/fpdart.dart

## Knowledge Gaps
- **136 isolated node(s):** `baseUrl`, `_Env`, `_enviedkeybaseUrl`, `_envieddatabaseUrl`, `baseUrl` (+131 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **6 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `approval_bloc.dart`, `AuthBloc`, `@LazySingleton`, `auth_repository_impl.dart`, `../../../../core/error/failures.dart`, `approval_remote_data_source.dart`, `auth_interceptor.dart`, `auth_local_data_source.dart`, `register_module.dart`, `package:injectable/injectable.dart`?**
  _High betweenness centrality (0.102) - this node is a cross-community bridge._
- **Why does `AuthBloc` connect `AuthBloc` to `_`, `login_form.dart`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **Why does `ApprovalBloc` connect `approval_bloc.dart` to `_`, `login_form.dart`, `AuthBloc`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **What connects `baseUrl`, `_Env`, `_enviedkeybaseUrl` to the rest of the system?**
  _136 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.06594071385359952 - nodes in this community are weakly interconnected._
- **Should `AppDelegate` be split into smaller, more focused modules?**
  _Cohesion score 0.05975609756097561 - nodes in this community are weakly interconnected._
- **Should `login_form.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06342780026990553 - nodes in this community are weakly interconnected._