// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learning_flutter/team_card.dart';

import 'teams.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FRC Scout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a team to scout:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamListPage()),
                );
              },
              child: Text('View Team List'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchListPage()),
                );
              },
              child: Text('View Match List'),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamListPage extends StatefulWidget {
  const TeamListPage({super.key});

  @override
  State<TeamListPage> createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  late Future<List<Team>> teamsData;
  late String searchString;

  @override
  void initState() {
    super.initState();

    teamsData = fetchEvents();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team List'),
      ),
      body: FutureBuilder(
          future: teamsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Team> teams = snapshot.data as List<Team>;
              List<Team> matchingEvents = teams.toList();

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: matchingEvents.length,
                      itemBuilder: (context, index) {
                        return TeamCard(team: matchingEvents[index]);
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}

class TeamDetailPage extends StatelessWidget {
  final int teamNumber;

  TeamDetailPage(this.teamNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team $teamNumber Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Team $teamNumber Details',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text('Team $teamNumber information will be displayed here.'),
          ],
        ),
      ),
    );
  }
}

class MatchListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match List'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Container(
                          color: Colors.white,
                        )));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Match ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MatchDetailPage(index + 1)),
              );
            },
          );
        },
      ),
    );
  }
}

class MatchDetailPage extends StatelessWidget {
  final int matchNumber;

  const MatchDetailPage(this.matchNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match $matchNumber Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Match $matchNumber Details',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text('Match $matchNumber information will be displayed here.'),
          ],
        ),
      ),
    );
  }
}
