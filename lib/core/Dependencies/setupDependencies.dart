import 'package:career_canvas/features/personalitytest/domain/repositories/PersonalityTestRepository.dart';
import 'package:career_canvas/features/personalitytest/domain/repository_impl/PersonalityTestRepositoryImpl.dart';
import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/user/data/datasources/user_local_data_source.dart';
import '../../features/user/data/datasources/user_remote_data_source.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/user/domain/repository_impl/user_repository_impl.dart';
import '../../features/user/domain/usecases/create_user.dart';
import '../../features/user/domain/usecases/delete_user.dart';
import '../../features/user/domain/usecases/get_all_users.dart';
import '../../features/user/domain/usecases/sync_users.dart';
import '../../features/user/domain/usecases/update_user.dart';
import '../../features/user/presentation/bloc/cubit/user_cubit.dart';
import '../network/api_client.dart';
import '../utils/constants.dart';
import '../network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:career_canvas/features/personalitytest/domain/repositories/PersonalityTestRepository.dart';


Future<String> getDatabasePath(String dbName) async {
  final directory = await getApplicationDocumentsDirectory();
  return join(directory.path, dbName); // Full path to the database
}

final GetIt getIt = GetIt.instance;
Future<void> setupDependencies() async {
 // Register Dio instance as a lazy singleton
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register PersonalityTestRepositoryImpl, injecting Dio
  getIt.registerLazySingleton<PersonalityTestRepository>(
      () => PersonalityTestRepositoryImpl(getIt<Dio>()));

  // Register PersonalityTestController, injecting PersonalityTestRepository
  getIt.registerLazySingleton<PersonalityTestController>(
      () => PersonalityTestController(getIt<PersonalityTestRepository>()));




  final dbPath = await getDatabasesPath();

  // Initialize the database
  final database = await openDatabase(
    '$dbPath/app.db',
    version: 2, // Increment the version
    onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.usersTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        birth_date TEXT,
        userName TEXT UNIQUE NOT NULL,
        is_active TEXT,
        sync_status TEXT NOT NULL DEFAULT 'pending'
      )
    ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute('''
        ALTER TABLE ${Constants.usersTable}
        ADD COLUMN birth_date TEXT
      ''');
      }
    },
  );

  // Register the database
  getIt.registerSingleton<Database>(database);

  // Register UserLocalDataSource only once
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(getIt<Database>()),
  );

  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(Dio()));

  // Register NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Register UserRemoteDataSource
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(getIt<ApiClient>()),
  );

  // Register UserRepository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: getIt<UserLocalDataSource>(),
      remoteDataSource: getIt<UserRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetAllUsers>(
    () => GetAllUsers(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<CreateUser>(
    () => CreateUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<DeleteUser>(
    () => DeleteUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<SyncUsers>(
    () => SyncUsers(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<UpdateUser>(
    () => UpdateUser(getIt<UserRepository>()),
  );

  // Register UserCubit
  getIt.registerFactory(() => UserCubit());
}
