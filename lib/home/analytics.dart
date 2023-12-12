import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  void initState() {
    super.initState();
    _initializeData();
  }

  List participantList = [];
  int totalParticipants = 0;
  int arrivedParticipants = 0;
  double arrivedPercentage = 0.0;
  Future<void> _initializeData() async {
    await _makeAPICall();

    setState(() {});
  }

  Future _makeAPICall() async {
    var token =
        "720239d96e4bbc73d16368290547ded46571708b2e82e67ec8af1a073cf7cd11";

    late var base_url = "http://143.244.129.21:2001";
    var url = Uri.parse('$base_url/certichain/verify_json');
    // await showAlertDialog(context);
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      List<dynamic> participantAPICall = jsonDecode(response.body);
      for (var i = 0; i < participantAPICall.length; i++) {
        var participantName = participantAPICall[i]["certificate"]["candidate"]
                ["attributes"]["name"] ??
            "";
        var arrived = participantAPICall[i]["issued"] ?? false;
        participantList
            .add({"participantName": participantName, "arrived": arrived});
      }
      setState(() {
        totalParticipants = participantList.length;
        arrivedParticipants = participantList
            .where((participant) => participant["arrived"])
            .length;
        arrivedPercentage = arrivedParticipants / totalParticipants;
        participantList.sort((a, b) {
          if (a["arrived"] == b["arrived"]) {
            return 0;
          } else if (a["arrived"]) {
            return -1;
          } else {
            return 1;
          }
        });
      });
      print('participantList $participantList');
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Set the preferred height here
          child: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('Participant List'),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the value as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularPercentIndicator(
                          radius: 60,
                          percent: arrivedPercentage,
                          progressColor: Colors.deepPurple,
                          backgroundColor: Colors.blue.shade100,
                          animation: true,
                          animationDuration: 1000,
                          lineWidth: 4.0,
                          center: Text(
                            "${(arrivedPercentage * 100).toStringAsFixed(2)} %",
                            style: const TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                          ),
                        ),
                        Text(
                          "$arrivedParticipants/$totalParticipants",
                          style: const TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: participantList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final participantDetail = participantList[index];
                    var participantName = participantDetail["participantName"];
                    bool arrived = participantDetail["arrived"];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Adjust the value as needed
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(participantName.toString()[0]),
                          ),
                          title: Text(
                            participantName.toString(),
                          ),
                          subtitle: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                width: 110, // Set the desired width
                                animation: true,
                                animationDuration: 1000,
                                progressColor: arrived
                                    ? Colors.green.shade600
                                    : Colors
                                        .red, // Change the color based on the condition
                                backgroundColor: Colors.orange,
                                lineHeight: 20,
                                percent: arrived
                                    ? 1.0
                                    : 0.0, // Set percent based on the condition
                                center: Text(
                                  arrived
                                      ? 'Arrived'
                                      : 'Not Arrived', // Set text based on the condition
                                  style: TextStyle(color: Colors.white),
                                ),
                                barRadius: const Radius.circular(15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
