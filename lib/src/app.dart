import 'package:career_canvas/features/login/presentation/screens/LoginScreen.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenOne.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenTwo.dart';
import 'package:career_canvas/src/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../features/Career/presentation/screens/CareerScreen.dart';
import '../features/DashBoard/presentation/screens/HomePage.dart';
import '../features/DashBoard/presentation/screens/dashboardScreen.dart';
import '../features/Networking/presentation/screens/networkingScreen.dart';
import '../features/login/presentation/screens/ProfileCompletionScreenFive.dart';
import '../features/login/presentation/screens/ProfileCompletionScreenFour.dart';
import '../features/login/presentation/screens/ProfileCompletionScreenThree.dart';
import '../features/user/presentation/screens/user_screen.dart';
import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          debugShowCheckedModeBanner: false,
          //restorationScopeId: 'uapp',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          initialRoute: LoginScreen.routeName,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case LoginScreen.routeName:
                    return LoginScreen();
                  case ProfileCompletionScreenOne.routeName:
                    return ProfileCompletionScreenOne();
                  case ProfileCompletionScreenTwo.routeName:
                    return ProfileCompletionScreenTwo();
                  case ProfileCompletionScreenThree.routeName:
                    return ProfileCompletionScreenThree();
                  case ProfileCompletionScreenFour.routeName:
                    return ProfileCompletionScreenFour();
                  case ProfileCompletionScreenFive.routeName:
                    return ProfileCompletionScreenFive();
                  case UserScreen.routeName:
                    return UserScreen();
                  case UserProfile.routeName:
                    return UserProfile();
                  case DashboardScreen.routeName:
                    return DashboardScreen();
                  case NetworkingScreen.routeName:
                    return NetworkingScreen();
                   case CareerScreen.routeName:
                    return CareerScreen();
                   case HomePage.routeName:
                    return HomePage();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
