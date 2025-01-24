import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/user/data/datasources/user_local_data_source.dart';
import 'package:career_canvas/features/user/data/models/user_model.dart';
import 'package:career_canvas/core/utils/VersionInfo.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  await VersionInfo.init();  // Initialize version information

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


  //-------------
  runApp(MyApp(settingsController: settingsController));
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
  final tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
  print('Tables in the database: $tables');

  // Query data from the "users" table
  final usersData = await db.rawQuery('SELECT * FROM users');
  print('Data in the users table: $usersData');
}


