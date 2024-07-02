import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddByBarcodeScreen extends StatelessWidget {
  const AddByBarcodeScreen({Key? key}) : super(key: key);

  Future<void> openBarcodeScanner(BuildContext context) async {
    String? barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Tarayıcı ekranın rengi
      'Cancel', // İptal butonunun metni
      true, // Flash açma seçeneği
      ScanMode.BARCODE, // Tarayıcı modu
    );

    if (barcodeScanRes != null) {
      // Tarayıcıdan dönen barkod değeriyle ilgili işlemleri yapabilirsiniz
      print('Scanned barcode: $barcodeScanRes');
      // Örneğin, burada barkod değerini kullanarak kitabı kütüphaneye ekleyebilirsiniz
    } else {
      // Barkod taraması iptal edildi veya hata oluştu
      print('Barcode scanning cancelled or failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Barkod tarayıcısını direkt olarak açmak için, build metodunda openBarcodeScanner fonksiyonunu çağırabiliriz
    openBarcodeScanner(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add by Barcode'),
      ),
      body: Center(
        child: Text('Opening barcode scanner...'),
      ),
    );
  }
}
