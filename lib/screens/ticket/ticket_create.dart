import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TicketCreate extends StatefulWidget {
  final String bus_number;

  TicketCreate({required this.bus_number, Key? key}) : super(key: key);

  @override
  _TicketCreateState createState() => _TicketCreateState();
}

class Place {
  final String name;
  final int distance;

  Place({required this.name, required this.distance});
}

class _TicketCreateState extends State<TicketCreate> {
  bool _loading = true;
  var baseUrl = "https://busease-server.vercel.app";
  final _storage = const FlutterSecureStorage();
  int busPricePerKM = 0;
  List<Place> places = [];
  List<Place> currentPossibleTravelPlaces = [];

  @override
  void initState() {
    super.initState();
    getBusData();
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

// curl --location 'https://busease-server.vercel.app/api/paas/status/' \
// --header 'Authorization: Bearer access_token'

  Future<bool> getPaasInfo() async {
    print('Getting PAAS Info');
    var url = Uri.parse("$baseUrl/api/paas/status/");
    var token = await _storage.read(key: 'access_token');
    try {
      var response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
          var res = jsonDecode(response.body.toString());
          print(res);
      if (response.statusCode == 200) {
        bool isValid =  res['status'];
        List<dynamic> possibleDestinations = res['possibleDestinations'];
        print(possibleDestinations.toString());
        if (isValid) {
          print('PAAS is valid');
          // Implement the logic to get the current possible travel places ( current possible travel places should be the intersection of the possible destinations and the bus route)
          currentPossibleTravelPlaces = places.where((place) => possibleDestinations.contains(place.name.toUpperCase())).toList();
          print("Current Possible Travel Places");
          currentPossibleTravelPlaces.forEach((place) {
            print(place.name + " " + place.distance.toString() );
          });
          return true;
        } else {
          showSnackBar(context, 'PAAS is not valid', Colors.red);
          return false;
        }
      } else {
        showSnackBar(context, 'Error fetching data or PAAS is Invalid', Colors.red);
        return false;
      }
    } catch (e) {
      print(e);
      showSnackBar(context, 'Error fetching data', Colors.red);
      return false;
    }
  }

  // curl --location --request GET 'https://busease-server.vercel.app/api/bus/getBusData' \
  // --header 'Content-Type: application/json' \
  // --data '{
  //     "busNumber" : "GJ-02-FT-1234"
  // }'
  // fetch bus data over http and set the loading state to false
  void getBusData() async {
    var url = Uri.parse("$baseUrl/api/bus/getBusData");
    var body = jsonEncode({
      'busNumber': widget.bus_number,
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      var res = jsonDecode(response.body.toString());
      print(res['bus']['busPricePerKilometer']);
      if (response.statusCode == 200) {
        // set the bus price per km and places
        setState(() {
          busPricePerKM = res['bus']['busPricePerKilometer'];
          places = res['bus']['busRoute']
              .map<Place>((place) =>
                  Place(name: place['name'], distance: place['distance']))
              .toList();
        });

        print("Places");
        places.forEach((place) {
          print(place.name + " " + place.distance.toString() );
        });

        // get the paas info
        bool isValid = await getPaasInfo();
        if (!isValid) {
          Navigator.pop(context);
        }



        setState(() {
          _loading = false;
        });
      } else {
        // show snackbar if there is an error and pop the screen
        print(res);
        showSnackBar(context, 'Error fetching data', Colors.red);
        Navigator.pop(context);
      }
    } catch (e) {
      // show snackbar if there is an error and pop the screen
      print(e);
      showSnackBar(context, 'Error fetching data', Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // show the circular progress indicator along with text that getting data while the bus data is being fetched and display the hello text after
    return _loading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Ticket Create'),
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Getting data...'),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Ticket Create'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello'),
                  Text(widget.bus_number),
                  Text('Bus Price Per KM: $busPricePerKM'),
                  Text('Bus Route:'),
                  Column(
                    children: places
                        .map((place) =>
                            Text('${place.name} - ${place.distance}'))
                        .toList(),
                  ),
                  Text('Current Possible Travel Places:'),
                  Column(
                    children: currentPossibleTravelPlaces
                        .map((place) =>
                            Text('${place.name} - ${place.distance}'))
                        .toList(),
                  ),
                ],
              ),
            ),
          );
  }
}
