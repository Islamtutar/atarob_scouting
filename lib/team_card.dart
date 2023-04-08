import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'teams.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(team.teamName),
              Text(
                "${team.teamNumber}",
                style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
              )
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TeamScoutingPage(
                  teamId: team.teamNumber,
                )));
      },
    );
  }
}

class TeamScoutingPage extends StatefulWidget {
  final int teamId;

  TeamScoutingPage({required this.teamId});

  @override
  _TeamScoutingPageState createState() => _TeamScoutingPageState();
}

class _TeamScoutingPageState extends State<TeamScoutingPage> {
  int _drivingScore = 0;
  int _shootingScore = 0;
  int _defenseScore = 0;
  double scoutScore = 0;

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'team_${widget.teamId}';
    final data = {
      'drivingScore': _drivingScore,
      'shootingScore': _shootingScore,
      'defenseScore': _defenseScore,
      'scoutScore': scoutScore
    };
    await prefs.setInt('$key.drivingScore', _drivingScore);
    await prefs.setInt('$key.shootingScore', _shootingScore);
    await prefs.setInt('$key.defenseScore', _defenseScore);
    scoutScore +=
        _drivingScore * 0.5 + _shootingScore * 0.5 + _defenseScore * 0.3;
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'team_${widget.teamId}';
    setState(() {
      _drivingScore = prefs.getInt('$key.drivingScore') ?? 0;
      _shootingScore = prefs.getInt('$key.shootingScore') ?? 0;
      _defenseScore = prefs.getInt('$key.defenseScore') ?? 0;
      scoutScore +=
          _drivingScore * 0.5 + _shootingScore * 0.5 + _defenseScore * 0.3;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scouting Team ${widget.teamId}'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$scoutScore"),
              Text('Driving Score: $_drivingScore'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _drivingScore--;
                    }),
                    child: const Text('Remove Driving Score'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _drivingScore++;
                    }),
                    child: const Text('Add Driving Score'),
                  ),
                ],
              ),
              Text('Shooting Score: $_shootingScore'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _shootingScore--;
                    }),
                    child: const Text('Remove Shooting Score'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _shootingScore++;
                    }),
                    child: const Text('Add Shooting Score'),
                  ),
                ],
              ),
              Text('Defense Score: $_defenseScore'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _defenseScore--;
                    }),
                    child: const Text('Remove Defense Score'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _defenseScore++;
                    }),
                    child: const Text('Add Defense Score'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                  Navigator.of(context).pop();
                },
                child: const Text('Save Data'),
              ),
            ],
          ),
        ));
  }
}
