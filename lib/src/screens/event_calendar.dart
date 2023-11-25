
import 'package:flutter/material.dart';

class EventCalendar extends StatefulWidget {
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  // Define variables to hold the selected view and events
  String _selectedView = 'month';
  final List<Event> _events = [
    Event(
      title: 'Academic Event',
      description: 'This is an academic event',
      date: DateTime.now().add(Duration(days: 1)),
      type: EventType.academic,
    ),
    Event(
      title: 'Social Event',
      description: 'This is a social event',
      date: DateTime.now().add(Duration(days: 2)),
      type: EventType.social,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
      ),
      body: Column(
        children: [
          // Add a row of buttons to toggle the view
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedView = 'day';
                  });
                },
                child: Text('Day'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedView = 'week';
                  });
                },
                child: Text('Week'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedView = 'month';
                  });
                },
                child: Text('Month'),
              ),
            ],
          ),
          // Display the events based on the selected view
          if (_selectedView == 'day')
            ..._events
                .where((event) =>
                    event.date.year == DateTime.now().year &&
                    event.date.month == DateTime.now().month &&
                    event.date.day == DateTime.now().day)
                .map((event) => EventListItem(event: event))
                .toList(),
          if (_selectedView == 'week')
            ..._events
                .where((event) =>
                    event.date.year == DateTime.now().year &&
                    event.date.weekday >= DateTime.now().weekday &&
                    event.date.weekday <= DateTime.now().weekday + 6)
                .map((event) => EventListItem(event: event))
                .toList(),
          if (_selectedView == 'month')
            ..._events
                .where((event) =>
                    event.date.year == DateTime.now().year &&
                    event.date.month == DateTime.now().month)
                .map((event) => EventListItem(event: event))
                .toList(),
        ],
      ),
    );
  }
}

// Define a class to represent an event
class Event {
  final String title;
  final String description;
  final DateTime date;
  final EventType type;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
  });
}

// Define an enum to represent the type of event
enum EventType {
  academic,
  social,
}

// Define a widget to display an event in the list
class EventListItem extends StatelessWidget {
  final Event event;

  const EventListItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title),
      subtitle: Text(event.description),
      trailing: Icon(
        event.type == EventType.academic ? Icons.school : Icons.people,
        color: event.date.isBefore(DateTime.now())
            ? Colors.grey
            : event.date.isAfter(DateTime.now())
                ? Colors.blue
                : Colors.black,
      ),
      onTap: () {
        // TODO: Implement the details screen and add to personal calendar or set reminders
      },
    );
  }
}
