import 'package:campus_navigation_system/src/models/event.dart';
import 'package:campus_navigation_system/src/services/event_service.dart';
import 'package:flutter/material.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  static const String routeName = '/eventCalendar';

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  String _selectedView = 'month';

  List<Event>? _events;

  @override
  void initState() {
    super.initState();

    initStateAsync();
  }

  void initStateAsync() async {
    _events = await EventService.fetchEvents();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
      ),
      body: _events == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                if (_selectedView == 'day')
                  ..._events!
                      .where((event) =>
                          DateTime.parse(event.startDateTime).year ==
                              DateTime.now().year &&
                          DateTime.parse(event.startDateTime).month ==
                              DateTime.now().month &&
                          DateTime.parse(event.startDateTime).day ==
                              DateTime.now().day)
                      .map((event) => EventListItem(event: event))
                      .toList(),
                if (_selectedView == 'week')
                  ..._events!
                      .where((event) =>
                          DateTime.parse(event.startDateTime).year ==
                              DateTime.now().year &&
                          DateTime.parse(event.startDateTime).weekday >=
                              DateTime.now().weekday &&
                          DateTime.parse(event.startDateTime).weekday <=
                              DateTime.now().weekday + 6)
                      .map((event) => EventListItem(event: event))
                      .toList(),
                if (_selectedView == 'month')
                  ..._events!
                      .where((event) =>
                          DateTime.parse(event.startDateTime).year ==
                              DateTime.now().year &&
                          DateTime.parse(event.startDateTime).month ==
                              DateTime.now().month)
                      .map((event) => EventListItem(event: event))
                      .toList(),
              ],
            ),
    );
  }
}

// Define a widget to display an event in the list
class EventListItem extends StatelessWidget {
  final Event event;

  const EventListItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(event.description),
      trailing: Icon(
        Icons.circle,
        color: DateTime.parse(event.startDateTime).isBefore(DateTime.now())
            ? Colors.grey
            : DateTime.parse(event.endDateTime).isAfter(DateTime.now())
                ? Colors.blue
                : Colors.black,
      ),
      onTap: () {
        // TODO: Implement the details screen and add to personal calendar or set reminders
      },
    );
  }
}
