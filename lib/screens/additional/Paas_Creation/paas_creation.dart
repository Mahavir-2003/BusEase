// create a stateful widget
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              const TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
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
