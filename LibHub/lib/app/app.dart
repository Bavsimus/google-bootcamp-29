import 'package:libhub/ui/personalLib/personal_library_view.dart';
import 'package:libhub/ui/registeration/login_view.dart';
import 'package:libhub/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView),
  MaterialRoute(page: SplashView),
  MaterialRoute(page: PersonalLibraryView, initial: true)
])
class App {}
