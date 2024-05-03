import 'dart:convert';
import 'package:bus_ease/providers/user_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  String userID = '';
  String paasID = '';
  String Depot = '';
  String type = '';
  

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
          userID = res['user'];
          paasID = res['paasId'];
          Depot = res['depot'];
          type = res['type'];
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


  // create ticket function to create a ticket
//   curl --location 'https://busease-server.vercel.app/api/ticket/create/' \
// --header 'Content-Type: application/json' \
// --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjAxMWJiOTA0MGYyZjViZjQ4ODg3M2EiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxNDQ4MTc4MywiZXhwIjoxNzE0NTY4MTgzfQ.O8g7G83qUgaYGw-gOTDOWpGX_5xeLYrMpcayoWLEfaI' \
// --data '{
//     "userID": "66011bb9040f2f5bf488873a",
//     "paasId": "6630edd23b4ff2156d92fdcb",
//     "passengerName": "Mahavir Patel",
//     "Depot": "UNJHA",
//     "type": "Student",
//     "from": "UNJHA",
//     "to": "MEHSANA",
//     "ticketQuantity": 1,
//     "ticketPrice": 100
// }'


  void createTicket() async {
    var url = Uri.parse("$baseUrl/api/ticket/create/");
    var token = await _storage.read(key: 'access_token');

    String userName = '${Provider.of<UserProvider>(context, listen: false).user!.firstName} ${Provider.of<UserProvider>(context, listen: false).user!.middleName.substring(0,1)}.  ${Provider.of<UserProvider>(context, listen: false).user!.lastName}';

    // var body = jsonEncode({
    //   'userID': await _storage.read(key: 'user_id'),
    //   'paasId': await _storage.read(key: 'paas_id'),
    //   'passengerName': await _storage.read(key: 'name'),
    //   'Depot': await _storage.read(key: 'depot'),
    //   'type': await _storage.read(key: 'type'),
    //   'from': 'UNJHA',
    //   'to': 'MEHSANA',
    //   'ticketQuantity': 1,
    //   'ticketPrice': 100,
    // });
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
