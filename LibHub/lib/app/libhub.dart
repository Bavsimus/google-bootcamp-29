
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';
import 'package:libhub/core/di/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LibHub extends StatelessWidget {
  const LibHub({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation> [
      DeviceOrientation.portraitUp, // app only works in vertical mode
    ]);
    return  ViewModelBuilder<AppBaseViewModel>.reactive(
        viewModelBuilder: () => getIt<AppBaseViewModel>(), // singleton: 1 instance of AppBaseViewModel
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => MaterialApp(
          theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [StackedService.routeObserver],
      title: 'Nutrically',
      debugShowCheckedModeBanner: false,
    ));
  }
}