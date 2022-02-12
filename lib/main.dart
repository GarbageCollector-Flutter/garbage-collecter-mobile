import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/init/lang/language_manager.dart';
import 'package:first_three/core/init/notifier/provider_list.dart';
import 'package:first_three/view/home/home_view.dart';
import 'package:first_three/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
        child: const MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application....
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      // navigatorObservers: [AnalytcisManager.instance.observer],
      theme: context.watch<ThemeNotifier>().currentTheme,
      home : SplashScreenView(
      navigateRoute: _buildStreamBuilder(),
      duration: 100,
      imageSize: 100,
      imageSrc: ApplicationConstants.APP_ICON_PATH,
      backgroundColor: const Color(0xff6b6bff),
    ),
    );
  }

  StreamBuilder<User?> _buildStreamBuilder() {
    return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (userSnapshot.hasData) {
                      return const HomeView();
                    } else {
                      return const LoginView();
                    }
                  });
  }
}
