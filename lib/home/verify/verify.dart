import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

Future<Participant> verifyTicket(String data) async {
  final response = await http.post(
    Uri.parse('http://143.244.129.21:2001/certichain/verify_json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'data': data,
    }),
  );
  
  final player = AudioPlayer();

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    await player.play(AssetSource('success.wav'));
    return Participant.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    await player.play(AssetSource('failure.wav'));
    throw Exception('Verification Failed');
  }
}

class Participant {
  // final int id;
  final String data;

  const Participant({required this.data});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      // id: json['id'],
      data: json['data'],
    );
  }
}

class VerifyPage extends StatefulWidget {
  final String? item;

  const VerifyPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  Future<Participant>? _futureParticipant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Ticket'),
      ),
      body: (_futureParticipant == null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verify ticket for',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  widget.item!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('NO'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _futureParticipant = verifyTicket(widget.item!);
                            });
                          },
                          child: const Text('YES'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : buildFutureBuilder(),
    );
  }

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: _futureParticipant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.green,
                  size: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  snapshot.data!.data,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const Text(
                  "Successfully Verified!!",
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.dangerous_outlined,
                  color: Colors.red,
                  size: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  '${snapshot.error}',
                  style: const TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}