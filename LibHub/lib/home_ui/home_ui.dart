import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String popularThisWeek = 'Popular this week';
  final String newFromFrineds = 'New from friends';
  final String labelHome = 'Home';
  final String labelScan = 'Scan and Add';
  final String labelProfile = 'Profile';

  List<dynamic> popularBooks = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
  ];
  List<dynamic> friendBooks = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchPopularBooks();
  //   fetchFriendBooks();
  // }

  // Future<void> fetchPopularBooks() async {
  //   // Popüler kitapları çekmek için API çağrısı
  //   final response = await http.get(Uri.parse('https://'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       popularBooks = json.decode(response.body);
  //     });
  //   }
  // }

  // Future<void> fetchFriendBooks() async {
  //   // Arkadaşlardan yeni kitapları çekmek için API çağrısı
  //   final response = await http.get(Uri.parse('https://'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       friendBooks = json.decode(response.body);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: ProjectPaddings.pagePaddingAll,
              child: Text(
                popularThisWeek,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ContainerWidgetBooks(
                screenHeight: screenHeight,
                popularBooks: popularBooks,
                screenWidth: screenWidth),
            Padding(
              padding: ProjectPaddings.pagePaddingAll,
              child: Text(
                newFromFrineds,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ContainerWidgetBooks(
                screenHeight: screenHeight,
                popularBooks: friendBooks,
                screenWidth: screenWidth),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () => _onItemTapped(0),
            child: Icon(Icons.home),
            backgroundColor:
                _selectedIndex == 0 ? ProjectColors.greenColor : Colors.grey,
          ),
          FloatingActionButton(
            onPressed: () => _onItemTapped(1),
            child: Icon(Icons.qr_code_scanner_outlined),
            backgroundColor: _selectedIndex == 1 ? ProjectColors.greenColor : Colors.grey,
          ),
          // Ortadaki yuvarlak buton için boşluk
          FloatingActionButton(
            onPressed: () => _onItemTapped(2),
            child: Icon(Icons.person),
            backgroundColor: _selectedIndex == 2 ? ProjectColors.greenColor : Colors.grey,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Container(
          height: 10.0, // Navigasyon çubuğunun yüksekliği
        ),
      ),
    );
  }
}

class ProjectPaddings {
  static const pagePaddingAll = EdgeInsets.all(6.0);
}

class ProjectColors {
  static const greenColor = Color(0xFF3C6E71);
}

class ContainerWidgetBooks extends StatelessWidget {
  const ContainerWidgetBooks({
    super.key,
    required this.screenHeight,
    required this.popularBooks,
    required this.screenWidth,
  });

  final double screenHeight;
  final List popularBooks;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularBooks.length,
        itemBuilder: (context, index) {
          return Container(
            width: screenWidth * 0.4,
            margin: ProjectPaddings.pagePaddingAll,
            child: Column(
              children: [
                Image.network(
                  popularBooks[index],
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.3,
                  fit: BoxFit.cover,
                ),
                Text('LibHub'),
              ],
            ),
          );
        },
      ),
    );
  }
}
