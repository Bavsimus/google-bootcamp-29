import 'package:flutter/material.dart';
import 'package:libhub/ui/home/add_by_barcode_screen.dart';
import 'package:libhub/ui/home/add_by_searching_screen.dart';

class AddOptionsWidget extends StatelessWidget {
  const AddOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5, // Ekranın yarısını kaplayacak şekilde ayarlayın
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBySearchingScreen(),
                  ),
                );
              },
              child: Text('Add by searching'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddByBarcodeScreen(),
                  ),
                );
              },
              child: Text('Add by barcode'),
            ),
          ],
        ),
      ),
    );
  }
}
