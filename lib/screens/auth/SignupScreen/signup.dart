import 'package:bus_ease/models/user.dart';
import 'package:bus_ease/providers/user_provider.dart';
import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:bus_ease/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSubmitting = false;
  String dropdownValue = 'male';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController aadharCardNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  // Initialize RegExp
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}");
  final RegExp phoneRegExp = RegExp(r"^\d{10}$");
  final RegExp aadharRegExp = RegExp(r"^\d{12}$");
  final RegExp passwordRegExp = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$");

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _registerUser() async {
    setState(() {
      isSubmitting = true;
    });

    // Validate the form
    if (firstNameController.text.isEmpty) {
      showSnackBar(context, "First Name is required", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (middleNameController.text.isEmpty) {
      showSnackBar(context, "Middle Name is required", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (lastNameController.text.isEmpty) {
      showSnackBar(context, "Last Name is required", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      showSnackBar(context, "Invalid Email", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (!phoneRegExp.hasMatch(phoneNumberController.text)) {
      showSnackBar(context, "Invalid Phone Number", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (!aadharRegExp.hasMatch(aadharCardNumberController.text)) {
      showSnackBar(context, "Invalid Aadhar Card Number", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (birthdayController.text.isEmpty) {
      showSnackBar(context, "Birthday is required", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(context, "Passwords do not match", Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    } else if (!passwordRegExp.hasMatch(passwordController.text)) {
      showSnackBar(
          context,
          "Password should be at least 8 characters long and include a combination of uppercase letters, lowercase letters, numbers, and special characters.",
          Colors.red);
      setState(() {
        isSubmitting = false;
      });
      return;
    }

    User user = User(
      firstName: firstNameController.text,
      middleName: middleNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      aadharCardNumber: aadharCardNumberController.text,
      dob: DateTime.parse(birthdayController.text),
      gender: dropdownValue,
      password: passwordController.text,
      role: "user",
    );

    AuthService authService = AuthService(userProvider: Provider.of<UserProvider>(_scaffoldKey.currentContext!, listen: false));
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
      key: _scaffoldKey,
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
                      controller: firstNameController,
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
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: middleNameController,
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
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: lastNameController,
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
                controller: emailController,
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
                controller: phoneNumberController,
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
                controller: aadharCardNumberController,
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
                        child: ValueListenableBuilder(
                          valueListenable: birthdayController,
                          builder: (BuildContext context,
                              TextEditingValue value, Widget? child) {
                                String formatedDate = "Birthday";
                                if(!birthdayController.text.isEmpty){
                                  DateTime dateTime = DateTime.parse(value.text);
                                  formatedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                                }
                            return Text(
                              formatedDate
                              ,
                              style: const TextStyle(
                                  color: Color(0x88ffffff),
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            );
                          },
                        ),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            birthdayController.text = pickedDate.toString();
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
                            style: const TextStyle(
                                color: Color(0x88ffffff),
                                fontSize: 14,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w500),
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
                controller: passwordController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: Colors.white,
                obscureText: true,
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
                height: 15,
              ),
              TextField(
                controller: confirmPasswordController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
                  fillColor: Color(0xff545560),
                  filled: true,
                  hintText: "Confirm Password",
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
              const SizedBox(
                height: 15,
              ),
              // Or Text with Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0x33ffffff),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "or",
                      style: TextStyle(
                        color: Color(0xaaffffff),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0x33ffffff),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // Sign Up Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff545560),
                      borderRadius:
                          BorderRadius.circular(3.0), // Adjust as needed
                    ),
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Color(0xaaffffff),
                          fontSize: 16,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
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
