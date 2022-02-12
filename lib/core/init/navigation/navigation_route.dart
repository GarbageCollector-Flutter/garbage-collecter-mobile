import 'package:first_three/core/components/init/not_found_widget.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/view/home/home_view.dart';
import 'package:first_three/view/login/login_view.dart';
import 'package:first_three/view/operation_detail/operation_detail_view.dart';
import 'package:first_three/view/operation_form/operation_form_view.dart';
import 'package:first_three/view/otp_sign/otp_sign_view.dart';
import 'package:first_three/view/profile/profile_view.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(const HomeView(), NavigationConstants.HOME_VIEW);
      case NavigationConstants.OTP_SIGN:
        final arguments = args.arguments as UserModel;
        return normalNavigate(const OtpSignView(), NavigationConstants.OTP_SIGN,
            args: arguments);
      case NavigationConstants.LOGIN_PAGE:
        return normalNavigate(
            const LoginView(), NavigationConstants.LOGIN_PAGE);

      case NavigationConstants.OPERATION_DETAIL:
        final arguments = args.arguments as String;
        return normalNavigate(
            const OperationDetailView(), NavigationConstants.OPERATION_DETAIL,
            args: arguments);
      case NavigationConstants.PROFILE:
        final arguments = args.arguments as String;
        return normalNavigate(const ProfileView(), NavigationConstants.PROFILE,
            args: arguments);
      case NavigationConstants.OPERATION_FORM:
        final arguments = args.arguments as String;
        return normalNavigate(const OperationFormView(), NavigationConstants.OPERATION_FORM,
            args: arguments);

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFound(),
        );
    }
  }

  PageRouteBuilder normalNavigate(Widget widget, String pageName,
      {Object? args}) {
    return PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => widget,

        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName, arguments: args));
  }
}
