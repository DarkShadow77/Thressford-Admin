import 'package:get_it/get_it.dart';

import '../../app/theme/bloc/theme_bloc.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impli.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Remote data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  /*sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(),
  );
  sl.registerLazySingleton<ReferralRemoteDataSource>(
    () => ReferralRemoteDataSource(),
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSource(),
  );*/

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl<AuthRemoteDataSource>()),
  );
  /*sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDataSource: sl<ProfileRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      notificationRemoteDataSource: sl<NotificationRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<ReferralRepository>(
    () => ReferralRepositoryImpl(
      referralRemoteDataSource: sl<ReferralRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      walletRemoteDataSource: sl<WalletRemoteDataSource>(),
    ),
  );*/

  // Blocs (Factories - because Blocs are short-lived)
  sl.registerSingleton<ThemeBloc>(ThemeBloc());
  /*sl.registerFactory<DashboardBloc>(() => DashboardBloc());
  sl.registerSingleton<AuthBloc>(AuthBloc(repo: sl<AuthRepository>()));
  sl.registerSingleton<ProfileBloc>(ProfileBloc(repo: sl<ProfileRepository>()));
  sl.registerSingleton<NotificationBloc>(
    NotificationBloc(repo: sl<NotificationRepository>()),
  );
  sl.registerSingleton<ReferralBloc>(
    ReferralBloc(repo: sl<ReferralRepository>()),
  );
  sl.registerSingleton<WalletBloc>(WalletBloc(repo: sl<WalletRepository>()));*/
}
