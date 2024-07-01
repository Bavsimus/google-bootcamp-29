import 'package:flutter/material.dart';
import 'package:libhub/ui/splash/splash_view_model.dart';

import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onViewModelReady: (viewmodel) => viewmodel
            .init(), // viewmodel hazır olduğunda modelden init fonksiyonunu çağır
        disposeViewModel: false,
        builder: (context, viewmodel, child) => Scaffold(
              body: Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'LibHub',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ));
  }
}
