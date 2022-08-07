import 'package:flutter/material.dart';

import 'events.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
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
            widget.event.name,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(widget.event.city)
        ],
      ),
    );
  }
}
