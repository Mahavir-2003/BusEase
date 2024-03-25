import 'package:bus_ease/models/user.dart';
import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:bus_ease/services/auth_service.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  bool isSubmitting = false;
  String dropdownValue = 'male';

  void _registerUser() async {
    setState(() {
      isSubmitting = true;
    });
    User user = User(
      firstName: "Mahavir",
      middleName: "Manubhai",
      lastName: "Patel",
      email: "mmp@mail.com",
      phoneNumber: "1234587890",
      aadharCardNumber: "123456789032",
      dob: DateTime(2003, 10, 20),
      gender: "male",
      password: "Mahavir@1234",
      role: "student",
    );

    AuthService authService = AuthService();
    var res = await authService.registerUser(user);
    var success = res['success'];
    var message = res['message'];

    if (success) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenNavigator(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383E48),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40,
            ),
            // Email/Phone/Aadhar Number  Field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xff545560),
                      filled: true,
                      hintText: "First Name",
                      hintStyle: TextStyle(
                        color: Color(0x88ffffff),
                        fontSize: 14,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xff545560),
                      filled: true,
                      hintText: "Middle Name",
                      hintStyle: TextStyle(
                        color: Color(0x88ffffff),
                        fontSize: 14,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xff545560),
                      filled: true,
                      hintText: "Last Name",
                      hintStyle: TextStyle(
                        color: Color(0x88ffffff),
                        fontSize: 14,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: Color(0xff545560),
                filled: true,
                hintText: "email",
                hintStyle: TextStyle(color: Color(0x88ffffff), fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: Color(0xff545560),
                filled: true,
                hintText: "PhoneNumber",
                hintStyle: TextStyle(color: Color(0x88ffffff), fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: Color(0xff545560),
                filled: true,
                hintText: "Aadhar Card Number",
                hintStyle: TextStyle(color: Color(0x88ffffff), fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff545560),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                      child: const Text('Birthday',
                          style: TextStyle(
                              color: Color(0x88ffffff),
                              fontSize: 14,
                              letterSpacing: 1.2)),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          print(pickedDate.toString());
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff545560),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          iconEnabledColor: const Color(0x88ffffff),
                          dropdownColor: const Color(0xff545560),
                          elevation: 0,
                          underline: Container(
                            height: 0,
                            color: const Color(0xff545560),
                          ),
                          style: const TextStyle(color: Color(0x88ffffff), fontSize: 14 , letterSpacing: 1.2, fontWeight: FontWeight.w500),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['male', 'female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: Color(0xff545560),
                filled: true,
                hintText: "Password",
                hintStyle: TextStyle(color: Color(0x88ffffff), fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Login Button
            GestureDetector(
              onTap: _registerUser,
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
                            "Sign Up",
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
    );
  }
}
