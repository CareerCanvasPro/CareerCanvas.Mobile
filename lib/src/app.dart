import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:career_canvas/core/models/mainRouting.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen1.dart';
import 'package:career_canvas/features/ProfileSettings/presentation/screens/ProfileSettings.dart';
import 'package:career_canvas/features/login/presentation/screens/LoginScreen.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenFive.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenOne.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenTwo.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../features/Career/presentation/screens/CareerScreen.dart';
import '../features/Career/presentation/screens/PersonalityTest/AnalyzingResultsScreen.dart';
import '../features/Career/presentation/screens/PersonalityTest/JobRecommendationScreen.dart';
import '../features/Career/presentation/screens/PersonalityTest/PersonalityTestField.dart';
import '../features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
import '../features/DashBoard/presentation/screens/HomePage.dart';
import '../features/Networking/presentation/screens/Mentors/ChatScreen.dart';
import '../features/Networking/presentation/screens/Mentors/MyMentorsTab.dart';
import '../features/Networking/presentation/screens/networkingScreen.dart';
import '../features/login/presentation/screens/ProfileCompletionScreenFour.dart';
import '../features/login/presentation/screens/ProfileCompletionScreenThree.dart';
import '../features/user/presentation/screens/user_screen.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  final MainRouteData mainRouteData;
  const MyApp({
    super.key,
    required this.settingsController,
    required this.mainRouteData,
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initDeepLinks(context);
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks(BuildContext context) async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      debugPrint('onAppLink: $uri');
      if (uri.path == '/auth/callback') {
        try {
          String token = uri.queryParameters['token'] ?? '';
          bool isNewUser =
              uri.queryParameters['isNewUser'].toString() == 'true';
          String email = uri.queryParameters['username'] ?? '';
          DateTime expiry = DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(uri.queryParameters["expiresAt"].toString()) ?? 0,
          );
          await TokenInfo.setToken(
            token,
            email,
            "Email",
            expiry,
          );
          print('Is new user: $isNewUser');
          if (isNewUser) {
            openAppLink(
              ProfileCompletionScreenOne.routeName,
              arguments: {
                'type': 'Email',
                'username': email,
                'token': token,
              },
            );
          } else {
            openAppLink(HomePage.routeName);
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 14.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Deep link received but not handled: ${uri.toString()}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      }
    });
  }

  void openAppLink(String routeName, {Object? arguments}) {
    Get.offNamedUntil(routeName, (_) => false, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //

    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: widget.settingsController,
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
          onGenerateTitle: (BuildContext context) => "Career Canvas",

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData.light().copyWith(
            primaryColor: primaryBlue, // Sets primary color
            colorScheme: ColorScheme.light(
              primary: primaryBlue, // Sets highlight color
              onPrimary: Colors.white, // Text color on primary
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          // initialRoute: widget.mainRouteData.initialRoute,
          initialRoute: ProfileCompletionScreenTwo.routeName,

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
                  case NetworkingScreen.routeName:
                    return NetworkingScreen();
                  case CareerScreen.routeName:
                    return CareerScreen();
                  case HomePage.routeName:
                    return HomePage();
                  case MyMentorsTab.routeName:
                    return MyMentorsTab();
                  case ChatScreen.routeName:
                    return ChatScreen();
                  case PersonalityTestScreen.routeName:
                    return PersonalityTestScreen();
                  case PersonalityTestScreen1.routeName:
                    return PersonalityTestScreen1();
                  case AnalyzingResultsScreen.routeName:
                    return AnalyzingResultsScreen();
                  case JobRecommendationScreen.routeName:
                    return JobRecommendationScreen();
                  case ProfileSettings.routeName:
                    return ProfileSettings();
                  default:
                    return LoginScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
