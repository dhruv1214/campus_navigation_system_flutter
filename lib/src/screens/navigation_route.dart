import 'package:campus_navigation_system/src/models/location.dart';
import 'package:campus_navigation_system/src/services/locations_service.dart';
import 'package:flutter/material.dart';
import 'package:campus_navigation_system/src/models/route.dart' as r;

class NavigationRoute extends StatefulWidget {
  const NavigationRoute({super.key});

  static const String routeName = '/navigationRoute';

  @override
  State<NavigationRoute> createState() => _NavigationRouteState();
}

class _NavigationRouteState extends State<NavigationRoute> {
  Location? location;
  Location? otherLocations;

  r.Route? route;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var locations =
        ModalRoute.of(context)!.settings.arguments as List<Location?>;

    if (location == null || otherLocations == null) {
      location = locations[0];
      otherLocations = locations[1];

      if (location != null && otherLocations != null) {
        getRoutes();
      }
    }
  }

  void onChangeSelectedIndex(int index) {

    var isLastIndex = index == route!.path.length - 1;

    if (isLastIndex) {
      // after 2 seconds

Future.delayed(const Duration(seconds: 1), () {


      displayDonationDialog();
});
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void displayDonationDialog() {
    var alert = AlertDialog(
      title: Text('Would you like to donate to the university?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/donate');
          },
          child: Text('Yes'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  void getRoutes() async {
    try {
      route = await LocationsService.fetchRoute(
          location!.locationId, otherLocations!.locationId);
    } catch (e) {
      print(e);
    }

    if (route == null || location == null || otherLocations == null) {
      location = null;
      otherLocations = null;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Navigation Route'),
      ),
      body: location == null || otherLocations == null || route == null
          ? const Center(child: CircularProgressIndicator())
          : 
          route!.path.isEmpty
              ? const Center(
                  child: Text('No route found'),
                )
              :
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Total Distance: ${route?.totalDistance ?? 0}m",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    flex: 4,
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("You are currently at:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                              Text(
                                  route?.path[_selectedIndex].name ??
                                      'No route found',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer)),
                              const SizedBox(height: 4),
                              Text(
                                "Room ${route?.path[_selectedIndex].roomNumber} | Floor ${route?.path[_selectedIndex].floor}",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                  route?.path[_selectedIndex].description ??
                                      'No route found',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer)),
                              SizedBox(height: 12),
                              // Divider
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.2),
                              ),
                              SizedBox(height: 12),
                              const Text("Distance to next location:"),
                              Text(
                                route?.path[_selectedIndex].distanceToNext
                                        .toString() ??
                                    'No route found',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: route?.path.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          color: _selectedIndex == index
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context).colorScheme.primaryContainer,
                          child: InkWell(
                            onTap: () {
                              onChangeSelectedIndex(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      route?.path[index].name ??
                                          'No route found',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  SizedBox(height: 4),
                                  Text(
                                    route?.path[index].roomNumber ??
                                        'No route found',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
