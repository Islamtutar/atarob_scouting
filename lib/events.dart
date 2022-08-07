import 'dart:convert';

import 'package:http/http.dart' as http;

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
  String searchTerms;

  Event({
    required this.name,
    required this.year,
    required this.city,
    this.searchTerms = "",
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      city: json["city"],
      name: json["name"],
      year: json["year"],
      searchTerms: json.values.whereType<String>().join(""),
    );
  }
}
