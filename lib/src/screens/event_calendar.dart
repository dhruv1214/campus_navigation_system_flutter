import 'package:campus_navigation_system/src/models/event.dart';
import 'package:campus_navigation_system/src/screens/event_details.dart';
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //all
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedView = 'all';
                          });
                        },
                        child: Text('All'),
                      ),
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
                ),
                
                if (_selectedView == 'all')
                  ..._events!
                      .map((event) => EventListItem(event: event))
                      .toList(),
                if (_selectedView == 'day')
                  ..._events!
                      .where((event) =>
                          event.startDateTime.year ==
                              DateTime.now().year &&
                          event.startDateTime.month ==
                              DateTime.now().month &&
                          event.startDateTime.day ==
                              DateTime.now().day)
                      .map((event) => EventListItem(event: event))
                      .toList(),
                if (_selectedView == 'week')
                  ..._events!
                      .where((event) =>
                          event.startDateTime.year ==
                              DateTime.now().year &&
                          event.startDateTime.month ==
                              DateTime.now().month &&
                          event.startDateTime.weekday >=
                              DateTime.now().weekday &&
                          event.startDateTime.weekday <=
                              DateTime.now().weekday + 6)
                      .map((event) => EventListItem(event: event))
                      .toList(),
                if (_selectedView == 'month')
                  ..._events!
                      .where((event) =>
                          event.startDateTime.year ==
                              DateTime.now().year &&
                          event.startDateTime.month ==
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
      style: ListTileStyle.list,
      title: Text(event.name),
      subtitle: Text(event.description),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(event: event),
          ),
        );
      },
      
      trailing: Icon(
        event.startDateTime.isBefore(DateTime.now())
            ? Icons.event_busy
            : event.endDateTime.isAfter(DateTime.now())
                ? Icons.event_available
                : Icons.event,
        color: event.startDateTime.isBefore(DateTime.now())
            ? Colors.grey
            : event.endDateTime.isAfter(DateTime.now())
                ? Colors.blue
                : Colors.black,
      ),
    );
  }
}
