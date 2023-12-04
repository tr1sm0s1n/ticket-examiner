import 'package:flutter/material.dart';
import 'package:ticket_examiner/home/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Examiner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.juraTextTheme(),
      ),
      home: const MyHomePage(title: 'Ticket Examiner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Set the preferred height here
        child: AppBar(
          title: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assets/logoBH.png',
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeWidget(),
                  ),
                );
              },
              icon: SizedBox(
                width: 150.0, // Set the width of the SizedBox as needed
                height: 150.0, // Set the height of the SizedBox as needed
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 150.0, // Set the size of the Icon as needed
                ),
              ),
              label: Text('Scan QR Code'), // Add optional text
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set border radius as needed
                ),
                elevation: 15.0, // Set the elevation as needed
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assets/kba_logo.png',
                width: 200.0, // Set the desired width
                height: 200.0, // Set the desired height
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.deepPurple,
          child: Container(
            height: 80,
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        size: 30,
                        Icons.analytics_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => {}),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeWidget(),
            ),
          );
        },
        tooltip: 'Scan QR',
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
