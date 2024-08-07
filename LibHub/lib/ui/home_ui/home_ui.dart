import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:libhub/ui/home_ui/home_view_model.dart';
import 'package:stacked/stacked.dart';

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
        appBar: AppBar(
          toolbarHeight: 8, // Yüksekliği buradan ayarlayabilirsiniz
        ),
        body: model.getPage(model.selectedIndex),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: model.selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 33, 116, 93),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            model.onItemTapped(index); // ViewModel method
          },
          items: _navBarItems,
        ),
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.house_outlined),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.add_circle_outline),
    title: const Text("Add"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.change_circle_outlined),
    title: const Text("Trade"),
    selectedColor: Colors.blueAccent,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.local_library_outlined),
    title: const Text("Personal Lib"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person_2_outlined),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];
