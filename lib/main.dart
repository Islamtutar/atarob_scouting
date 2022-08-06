import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Event>> eventsData;

  @override
  void initState() {
    super.initState();

    eventsData = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("My cool flutter app"),
          ),
          body: ListView.builder(
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: eventsData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Event event = (snapshot.data as List<Event>)[index];
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.lightBlue[50],
                      ),
                      child: Column(
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(event.city)
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            },
          )),
    );
  }
}

Future<List<Event>> fetchEvents() async {
  final response = await http.get(
    Uri.parse('https://www.thebluealliance.com/api/v3/events/2022'),
    headers: {
      "X-TBA-Auth-Key":
          "lSKhhpNwQCVhq3LXPJFDffLGdXQFMZhyHKQp7qbCubNkyl2JOjo0gGPpWQdurXPk",
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    var eventList = jsonDecode(response.body) as List<dynamic>;
    return eventList.map((e) => Event.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Event {
  final String name;
  final int year;
  final String city;

  const Event({
    required this.name,
    required this.year,
    required this.city,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      city: json["city"],
      name: json["name"],
      year: json["year"],
    );
  }
}
