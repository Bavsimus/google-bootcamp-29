import "package:flutter/material.dart";

import "package:libhub/home_ui/home_view_model.dart";

import "package:stacked/stacked.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(),
              body: model.getPage(model.selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Homes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_a_photo_outlined),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_library_outlined),
                    label: 'Personal Lib',
                  ),
                ],
                currentIndex: model.selectedIndex,
                selectedItemColor: Color.fromARGB(255, 33, 116, 93),
                onTap: model.onItemTapped,
              ),
            ));
  }
}
