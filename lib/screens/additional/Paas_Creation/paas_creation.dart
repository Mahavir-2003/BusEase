// create a stateful widget
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaasCreation extends StatefulWidget {
  const PaasCreation({super.key});

  @override
  createState() => _PaasCreationState();
}

// create a state class
class _PaasCreationState extends State<PaasCreation> {
  String fromDropdownValue = 'UNJHA';
  String toDropdownValue = 'UNAVA';
  String durationDropdownValue = '1 MONTH';
  String paasTypeDropdownValue = 'NORMAL';
  String depotDropdownValue = 'UNJHA';

  bool isSubmitting = false;

  final _storage = const FlutterSecureStorage();
  var baseUrl = "https://busease-server.vercel.app";

  final TextEditingController organizationController = TextEditingController();

//   curl --location 'http://localhost:8080/api/paas/create/' \
// --header 'Content-Type: application/json' \
// --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjAxMWJiOTA0MGYyZjViZjQ4ODg3M2EiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxMzc2MjY0MSwiZXhwIjoxNzEzODQ5MDQxfQ.f0OxFAfiTEYM6egGbSIQ53SZXaSbP2SPvHOVstUjX3I' \
// --data '{
//     "organization": "Ganpat University",
//     "from": "Unava",
//     "to": "MEHSANA",
//     "expiryDate": "2024-12-31",
//     "paasType": "NORMAL",
//     "depot": "UNJHA"
// }'

// create paas function that will be called when the user clicks on the create paas button which calls api endpoint to create a paas

  void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}

  Future<void> createPaas() async {
    setState(() {
      isSubmitting = true;
    });

    var token = await _storage.read(key: "access_token");

    var url = Uri.parse("$baseUrl/api/paas/create/");

    // check if the organization field is empty
    if (organizationController.text.isEmpty) {
      showSnackBar(context, "Organization field is required", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    }

    // create the Expiry Date based on the duration selected
    var expiryDate = DateTime.now().add(
      // check the duration selected and add the days accordingly for 1,3,6 months
      durationDropdownValue == '1 MONTH'
          ? const Duration(days: 30)
          : durationDropdownValue == '3 MONTH'
              ? const Duration(days: 90)
              : durationDropdownValue == '6 MONTH'
                  ? const Duration(days: 180)
                  : const Duration(days: 30),
    );

    var body = jsonEncode({
      'organization': organizationController.text.toString(),
      'from': fromDropdownValue,
      'to': toDropdownValue,
      'expiryDate': expiryDate.toString(),
      'paasType': paasTypeDropdownValue,
      'depot': depotDropdownValue,
    });

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: body,
      );
      var res = jsonDecode(response.body);
      if (response.statusCode == 201) {
        // write user id and paas id and user origin to secure storage
        await _storage.write(key: "paas_id", value: res["_id"]);
        await _storage.write(key: "user_id", value: res["user"]);
        await _storage.write(key: "user_origin", value: res["from"].toString().toUpperCase());

        showSnackBar(context, "Paas Created Successfully", Colors.green);
        setState(() {
          isSubmitting = false;
        });
        // navigate to the home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showSnackBar(context, "Some Error Occured or you already have created the paas. ${response.statusCode}",  Colors.red);
        setState(() {
          isSubmitting = false;
        });
      }
    } catch (e) {
      showSnackBar(context, "An error occurred: $e", Colors.red);
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383E48),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Create Your Paas",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: organizationController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  fillColor: Color(0xff545560),
                  filled: true,
                  hintText: "Enter Your Organization",
                  hintStyle: TextStyle(
                    color: Color(0x88ffffff),
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        DropdownButton<String>(
                          value: fromDropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          iconEnabledColor: const Color(0x88ffffff),
                          dropdownColor: const Color(0xff545560),
                          elevation: 0,
                          underline: Container(
                            height: 0,
                            color: const Color(0xff545560),
                          ),
                          style: const TextStyle(
                              color: Color(0x88ffffff),
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                          onChanged: (String? newValue) {
                            setState(() {
                              fromDropdownValue = newValue!;
                            });
                          },
                          items: <String>['UNJHA', 'UNAVA', 'BHANDU']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "To",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        DropdownButton<String>(
                          value: toDropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          iconEnabledColor: const Color(0x88ffffff),
                          dropdownColor: const Color(0xff545560),
                          elevation: 0,
                          underline: Container(
                            height: 0,
                            color: const Color(0xff545560),
                          ),
                          style: const TextStyle(
                              color: Color(0x88ffffff),
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                          onChanged: (String? newValue) {
                            setState(() {
                              toDropdownValue = newValue!;
                            });
                          },
                          items: <String>['UNJHA', 'UNAVA', 'BHANDU']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Duration",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        DropdownButton<String>(
                          value: durationDropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          iconEnabledColor: const Color(0x88ffffff),
                          dropdownColor: const Color(0xff545560),
                          elevation: 0,
                          underline: Container(
                            height: 0,
                            color: const Color(0xff545560),
                          ),
                          style: const TextStyle(
                              color: Color(0x88ffffff),
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                          onChanged: (String? newValue) {
                            setState(() {
                              durationDropdownValue = newValue!;
                            });
                          },
                          items: <String>['1 MONTH', '3 MONTH', '6 MONTH']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Paas Type",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        DropdownButton<String>(
                          value: paasTypeDropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          iconEnabledColor: const Color(0x88ffffff),
                          dropdownColor: const Color(0xff545560),
                          elevation: 0,
                          underline: Container(
                            height: 0,
                            color: const Color(0xff545560),
                          ),
                          style: const TextStyle(
                              color: Color(0x88ffffff),
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                          onChanged: (String? newValue) {
                            setState(() {
                              paasTypeDropdownValue = newValue!;
                            });
                          },
                          items: <String>['NORMAL', 'EXPRESS']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Depot Selection Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Depot",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  DropdownButton<String>(
                    value: depotDropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    iconEnabledColor: const Color(0x88ffffff),
                    dropdownColor: const Color(0xff545560),
                    elevation: 0,
                    underline: Container(
                      height: 0,
                      color: const Color(0xff545560),
                    ),
                    style: const TextStyle(
                        color: Color(0x88ffffff),
                        fontSize: 14,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500),
                    onChanged: (String? newValue) {
                      setState(() {
                        depotDropdownValue = newValue!;
                      });
                    },
                    items: <String>['UNJHA', 'MEHSANA']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: createPaas,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFFC857),
                      borderRadius:
                          BorderRadius.circular(3.0), // Adjust as needed
                    ),
                    child: Center(
                      child: isSubmitting // Replace with your actual condition
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Color(
                                  0xff111111,
                                ),
                                strokeWidth: 2.0,
                              ),
                            )
                          : const Text(
                              "Create Paas",
                              style: TextStyle(
                                color: Color(0xff111111),
                                fontSize: 16,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
