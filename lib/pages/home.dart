import 'package:flutter/material.dart';
import 'package:qrcodescanner/menu/settings.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  String? qrValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Scanned QR Code', style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),

                child: MobileScanner(
                  onDetect: (capture) {
                    final barcode = capture.barcodes.first;
                    final String? code = barcode.rawValue;
                    if (code != null) {
                      setState(() => qrValue = code);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: qrValue),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Scanned QR Value',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    if (qrValue != null) {
                      Clipboard.setData(ClipboardData(text: qrValue!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard')),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.white)),
          ),
          ListTile(
            title: const Text('Settings', style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              Navigator.of(context).push(
                pageRoute(const Settings()),
              );
            },
          ),
        ],
      ),
    );
  }

  PageRouteBuilder<dynamic> pageRoute(Widget page) {
    return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => page,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Start from right
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              );
  }
}