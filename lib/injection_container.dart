import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mero_din_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/approve_team_remote_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/curreent_team_info_remote_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/search_user_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/repositories/approve_repository_impl.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/repositories/current_team_info_repository_impl.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/repositories/search_user_repository_impl.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/approve_repository.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/current_team_info_repository.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/search_user_repository.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/add_current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/approve_usecase.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/delete_current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/search_user_usecase.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/update_current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/bloc/approve_team_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:mero_din_app/features/profile/data/datasources/user_remote_datasource.dart';
import 'package:mero_din_app/features/profile/data/repositories/user_repositiory_impl.dart';
import 'package:mero_din_app/features/profile/domain/repositories/user_respository.dart';
import 'package:mero_din_app/features/profile/domain/usecases/get_current_user_usercase.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_bloc.dart';
import 'package:mero_din_app/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:mero_din_app/features/schedule/data/respositories/schedule_repository_impl.dart';
import 'package:mero_din_app/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:mero_din_app/features/schedule/domain/usecases/add_schedule_usecase.dart';
import 'package:mero_din_app/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:mero_din_app/features/teamInfo/data/datasources/team_info_remote_datasource.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/delete_team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/update_team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';
import 'core/services/auth_service.dart';

import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/teamInfo/data/repositories/team_info_repository_impl.dart';
import 'features/teamInfo/domain/repositories/team_info_repository.dart';
import 'features/teamInfo/domain/usercases/add_team_info_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  // Register SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Internet connection checker
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  sl.registerLazySingleton(() => AuthService(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Get token from SharedPreferences here once, then inject it
  // final token = prefs.getString('token') ?? '';

  //auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));

  sl.registerFactory(() => AuthBloc(sl(), sl()));

  //currentUser
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetCurrentUserUsercase(sl()));

  sl.registerFactory(() => CurrentUserBloc(sl()));

  //teamInfo
  sl.registerLazySingleton<TeamInfoRemoteDataSource>(
    () => TeamInfoRemoteDatasourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<TeamInfoRepository>(
    () => TeamInfoRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => TeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddTeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => UpdatTeamInfoUseCase(sl()));

  sl.registerFactory(() => TeamInfoBloc(sl(), sl(), sl(), sl()));

  //CurrentteamInfo
  sl.registerLazySingleton<CurrentTeamInfoRemoteDatasource>(
    () => CurrentTeamInfoRemoteDatasourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CurrentTeamInfoRepository>(
    () => CurrentTeamInfoRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => CurrentTeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddCurrentTeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCurrentTeamInfoUseCase(sl()));
  sl.registerLazySingleton(() => UpdatCurrentTeamInfoUseCase(sl()));

  sl.registerFactory(() => CurrentTeamInfoBloc(sl(), sl(), sl(), sl()));

  //CurrentteamInfo
  sl.registerLazySingleton<SearchUserDatasource>(
    () => SearchUserDatasourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SearchUserRepository>(
    () => SearchUserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => SearchUsersUseCase(sl()));

  sl.registerFactory(() => UserSearchBloc(sl()));

  //approveRequest
  sl.registerLazySingleton<ApproveTeamRemoteDatasource>(
    () => ApproveTeamRemotaDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ApproveRepository>(
    () => ApproveRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => ApproveUsecase(sl()));

  sl.registerFactory(() => ApproveTeamBloc(sl()));

  //schedule
  sl.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetSchedulesUseCase(sl()));

  sl.registerFactory(() => AddScheduleUseCase(sl()));
  sl.registerFactory(() => ScheduleBloc(sl(), sl()));

  // //for company info
  // sl.registerLazySingleton<CompanyInfoRemoteDataSource>(
  //     () => CompanyInfoRemoteDataSourceImpl(sl(), sl()));
  // sl.registerLazySingleton<CompanyInfoRepository>(
  //     () => CompanyInfoRepositoryImpl(sl(), sl()));
  // sl.registerLazySingleton(() => CompanyInfoUseCase(sl()));
  // sl.registerLazySingleton(() => UpdateCompanyInfoUseCase(sl()));

  // sl.registerFactory(() => CompanyInfoBloc(sl(), sl()));

  // //for upload Image
  // sl.registerLazySingleton<UploadImageRemoteDataSource>(
  //     () => UploadImageRemoteDataSourceImpl(
  //           sl(),
  //         ));
  // sl.registerLazySingleton<UploadImageRepository>(
  //     () => UploadImageRepositoryImpl(sl()));
  // sl.registerLazySingleton(() => UploadImageDataUseCase(sl()));

  // sl.registerFactory(() => UploadBloc(sl()));

  //billresponse
}
