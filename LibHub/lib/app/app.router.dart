// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:libhub/ui/registeration/forget_password_view.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:libhub/ui/personalLib/personal_library_view.dart' as _i4;
import 'package:libhub/ui/registeration/login_view.dart' as _i2;
import 'package:libhub/ui/registeration/sign_up_view.dart' as _i5;
import 'package:libhub/ui/splash/splash_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;
import 'package:stacked_services/stacked_services.dart' as _i6;

class Routes {
  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const personalLibraryView = '/';

  static const forgotPasswordView = '/forgot-password-view';

  static const signUpView = '/sign-up-view';

  static const all = <String>{
    loginView,
    splashView,
    forgotPasswordView,
    signUpView,
    personalLibraryView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.splashView,
      page: _i3.SplashView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordView,
      page: _i4.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i5.SignUpView,
      Routes.personalLibraryView,
      page: _i4.PersonalLibraryView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {

      return _i6.MaterialPageRoute<dynamic>(

      return _i5.MaterialPageRoute<dynamic>(

        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.SplashView: (data) {

      return _i6.MaterialPageRoute<dynamic>(

      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.SplashView(),
        settings: data,
      );
    },
    _i4.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i5.SignUpView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SignUpView(),

    _i4.PersonalLibraryView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.PersonalLibraryView(),

        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}


class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgotPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i7.NavigationService {

extension NavigatorStateExtension on _i6.NavigationService {

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordView({
    _i6.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgotPasswordView,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([

  Future<dynamic> navigateToPersonalLibraryView([

    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,

    return navigateTo<dynamic>(Routes.personalLibraryView,

        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }


  Future<dynamic> replaceWithForgotPasswordView({
    _i6.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.forgotPasswordView,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([

  Future<dynamic> replaceWithPersonalLibraryView([

    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {

    return replaceWith<dynamic>(Routes.signUpView,

    return replaceWith<dynamic>(Routes.personalLibraryView,

        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
