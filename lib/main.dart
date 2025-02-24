import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/mainRouting.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/HomePage.dart';
import 'package:career_canvas/features/login/presentation/screens/LoginScreen.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenOne.dart';
import 'package:career_canvas/features/user/data/datasources/user_local_data_source.dart';
import 'package:career_canvas/features/user/data/models/user_model.dart';
import 'package:career_canvas/core/utils/VersionInfo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sqflite/sqflite.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  await VersionInfo.init(); // Initialize version information
  await TokenInfo.init();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  //--------------
  await setupDependencies(); // Ensure dependencies are set up

  // Get the database and userLocalDataSource from GetIt
  //final database = getIt<Database>();
  //await resetDatabase(database); // Reset for development only

  final userLocalDataSource = getIt<UserLocalDataSource>();
  await userLocalDataSource.initDatabase();
  //await insertExampleData(userLocalDataSource); // Insert example data

  // Log table data
  await logUsersTableData();
  final mainRouteData = await checkIfUserLoggedIn();

  //-------------
  runApp(
    MyApp(
      settingsController: settingsController,
      mainRouteData: mainRouteData,
    ),
  );
}

Future<MainRouteData> checkIfUserLoggedIn() async {
  MainRouteData routeData = MainRouteData(
    initialRoute: LoginScreen.routeName,
  );
  if (TokenInfo.isloggedInUser()) {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiClient.userBase,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      final response = await dio.get(
        "${ApiClient.userBase}/user/profile",
        options: Options(
          headers: {
            'Content-Type': "application/json",
            "Authorization": "Bearer ${TokenInfo.token}",
          },
        ),
      );
      print(response.data['data']);
      UserProfileData profile = UserProfileData.fromMap(response.data['data']);
      print(profile.toString());
      routeData.userProfile = profile;
      routeData.initialRoute = HomePage.routeName;
      return routeData;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data["message"]);
        print(e.response!.statusCode);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode != null && e.response!.statusCode == 404) {
          routeData.initialRoute = ProfileCompletionScreenOne.routeName;
        }
        return routeData;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        routeData.initialRoute = HomePage.routeName;
        return routeData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  return routeData;
}

Future<void> insertExampleData(UserLocalDataSource userLocalDataSource) async {
  // Example user data
  final exampleUsers = [
    UserModel(
      name: 'taj',
      email: 'john.doe@example.com',
      birthDate: '1990-01-01',
      userName: 'johndoe',
      isActive: 'true',
      syncStatus: 'pending',
    ),
    UserModel(
      name: 'raz',
      email: 'jane.doe@example.com',
      birthDate: '1992-05-10',
      userName: 'janedoe',
      isActive: 'true',
      syncStatus: 'pending',
    ),
  ];

  // Insert each user into the database
  for (var user in exampleUsers) {
    await userLocalDataSource.createUser(user);
  }

  print('Example users inserted.');
}

Future<void> resetDatabase(Database database) async {
  await database.execute('DROP TABLE IF EXISTS users');
  await database.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      birth_date TEXT,
      userName TEXT UNIQUE NOT NULL,
      is_active TEXT,
      sync_status TEXT NOT NULL DEFAULT 'pending'
    )
  ''');
}

Future<void> logUsersTableData() async {
  final dbPath = await getDatabasesPath();
  final db = await openDatabase('$dbPath/app.db');

  // Log all tables
  final tables =
      await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
  print('Tables in the database: $tables');

  // Query data from the "users" table
  final usersData = await db.rawQuery('SELECT * FROM users');
  print('Data in the users table: $usersData');
}
