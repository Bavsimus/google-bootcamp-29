import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';

class SplashViewModel extends AppBaseViewModel {
  // Her viewmodeli AppBaseViewModelden extend etmek gerekiyor
  @override
  init() {
    Future<void>.delayed(const Duration(seconds: 2), () {
      navigationService.navigateTo(Routes.loginView);
    });
  }
}
