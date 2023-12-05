import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Set the preferred height here
        child: AppBar(
          title: Text('Participant List'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularPercentIndicator(
                radius: 60,
                percent: 0.2,
                progressColor: Colors.blue.shade900,
                backgroundColor: Colors.blue.shade100,
                animation: true,
                animationDuration: 1000,
                lineWidth: 12.0,
                center: Text(
                  (0.2 * 100).toStringAsFixed(2),
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 18),
                )),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 56,
                  color: Colors.blueGrey,
                ),
                title: Text(
                    'Two-linsdsds derer erwerere werew ewrer werfer er er werre ListTile'),
                subtitle: Text('Here is a second line'),
              ),
            )
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
        onPressed: () {},
        tooltip: 'Scan QR',
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
