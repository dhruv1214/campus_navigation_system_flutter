import 'package:campus_navigation_system/src/models/location.dart';
import 'package:campus_navigation_system/src/services/locations_service.dart';
import 'package:flutter/material.dart';

class StartRoute extends StatefulWidget {
  const StartRoute({super.key});

  static const String routeName = '/startRoute';

  @override
  State<StartRoute> createState() => _StartRouteState();
}

class _StartRouteState extends State<StartRoute> {
  Location? location;
  List<Location> otherLocations = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (location == null ||
        location != ModalRoute.of(context)!.settings.arguments as Location) {
      location = ModalRoute.of(context)!.settings.arguments as Location;
      getLocations();
    }
  }

  getLocations() async {
    try{
    otherLocations = await LocationsService.fetchLocationsByBuildingId(
        location!.buildingId);

otherLocations.removeWhere((element) => element.id == location!.id);

    setState(() {});
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From', style: TextStyle(fontSize: 12),),
            Text(location!.name),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2
              ),
              itemCount: otherLocations.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/navigationRoute',
                      arguments: [
                        location,
                        otherLocations[index],
                      ],
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(otherLocations[index].name),
                        Text(otherLocations[index].roomNumber, style: TextStyle(fontSize: 12),),
                        Text("F: ${otherLocations[index].floor}", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      
        ],
      ),
    );
  }
}
