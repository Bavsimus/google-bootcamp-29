import 'package:libhub/home_ui/home_ui.dart';

import 'package:libhub/ui/registeration/forget_password_view.dart';
import 'package:libhub/ui/personalLib/personal_library_view.dart';
import 'package:libhub/ui/registeration/login_view.dart';
import 'package:libhub/ui/registeration/sign_up_view.dart';
import 'package:libhub/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: HomePage ),
  MaterialRoute(page: SplashView),
  MaterialRoute(page: ForgotPasswordView),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: PersonalLibraryView)
])
class App {}
