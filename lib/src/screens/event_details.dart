import 'package:campus_navigation_system/src/models/event.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                event.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                event.description,

                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 16),
                  SizedBox(width: 8),
                  Text(
                    timeago.format(event.startDateTime),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 16),
                  SizedBox(width: 8),
                  Text(
                    DateFormat('dd MMMM yyyy').format(event.startDateTime),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, size: 16),
                  SizedBox(width: 8),
                  Text(
                    event.location.name, // Assuming Location has an address field
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              // Add more widgets as needed to display other event details
            ],
          ),
        ),
      ),
    );
  }
}
