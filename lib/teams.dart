import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Team>> fetchEvents() async {
  final response = await http.get(
    Uri.parse(
        'https://www.thebluealliance.com/api/v3/event/2023tuis/teams/simple'),
    headers: {
      "X-TBA-Auth-Key":
          "aN3kcUDJlmAyJ8Vw3WUT66C1lTdifrzJ3XvZ40MQcEUM8ogQjWOakfhS9YFTm2Di",
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    var eventList = jsonDecode(response.body) as List<dynamic>;
    return eventList.map((e) => Team.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Team {
  final String teamName;
  final int teamNumber;

  Team({
    required this.teamName,
    required this.teamNumber,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(teamNumber: json["team_number"], teamName: json["nickname"]);
  }
}
