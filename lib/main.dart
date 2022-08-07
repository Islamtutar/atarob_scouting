// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learning_flutter/event_card.dart';

import 'events.dart';

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
  late String searchString;

  @override
  void initState() {
    super.initState();

    eventsData = fetchEvents();
    searchString = "";
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("My cool flutter app"),
        ),
        body: FutureBuilder(
          future: eventsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Event> events = snapshot.data as List<Event>;
              List<Event> matchingEvents = events
                  .where((event) => event.city.contains(searchString))
                  .toList();
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Search for city',
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: matchingEvents.length,
                      itemBuilder: (context, i) {
                        return EventCard(event: matchingEvents[i]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}
