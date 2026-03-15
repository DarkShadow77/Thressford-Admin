import 'package:get_it/get_it.dart';
import 'package:thressford_admin/features/user_management/presentation/bloc/users_bloc.dart';

import '../../app/theme/bloc/theme_bloc.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impli.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impli.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/referral_management/data/data_sources/referral_remote_data_source.dart';
import '../../features/referral_management/data/repositories/referral_repository_impli.dart';
import '../../features/referral_management/domain/repositories/referral_repository.dart';
import '../../features/referral_management/presentation/bloc/referral_bloc.dart';
import '../../features/settings/data/data_sources/admin_remote_data_source.dart';
import '../../features/settings/data/repositories/admin_repository_impli.dart';
import '../../features/settings/domain/repositories/admin_repository.dart';
import '../../features/settings/presentation/bloc/admin_bloc.dart';
import '../../features/user_management/data/data_sources/user_management_remote_data_source.dart';
import '../../features/user_management/data/repositories/user_management_repository_impli.dart';
import '../../features/user_management/domain/repositories/user_management_repository.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Remote data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(),
  );
  sl.registerLazySingleton<AdminRemoteDataSource>(
    () => AdminRemoteDataSource(),
  );
  sl.registerLazySingleton<UserManagementRemoteDataSource>(
    () => UserManagementRemoteDataSource(),
  );
  sl.registerLazySingleton<ReferralRemoteDataSource>(
    () => ReferralRemoteDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      dashboardRemoteDataSource: sl<DashboardRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<AdminRepository>(
    () =>
        AdminRepositoryImpl(adminRemoteDataSource: sl<AdminRemoteDataSource>()),
  );
  sl.registerLazySingleton<UserManagementRepository>(
    () => UserManagementRepositoryImpl(
      usersRemoteDataSource: sl<UserManagementRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<ReferralRepository>(
    () => ReferralRepositoryImpl(
      referralRemoteDataSource: sl<ReferralRemoteDataSource>(),
    ),
  );

  // Blocs (Factories - because Blocs are short-lived)
  sl.registerSingleton<ThemeBloc>(ThemeBloc());
  sl.registerSingleton<AuthBloc>(AuthBloc(repo: sl<AuthRepository>()));
  sl.registerSingleton<DashboardBloc>(
    DashboardBloc(repo: sl<DashboardRepository>()),
  );
  sl.registerSingleton<AdminBloc>(AdminBloc(repo: sl<AdminRepository>()));
  sl.registerSingleton<UsersBloc>(
    UsersBloc(repo: sl<UserManagementRepository>()),
  );
  sl.registerSingleton<ReferralBloc>(
    ReferralBloc(repo: sl<ReferralRepository>()),
  );
}
