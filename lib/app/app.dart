import 'package:libhub/ui/registeration/login_view.dart';
import 'package:libhub/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:libhub/ui/home/home_page_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView),
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: HomePageView),
])
class App {}
