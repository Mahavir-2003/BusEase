import 'package:bus_ease/screens/auth/SignupScreen/signup.dart';
import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:bus_ease/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  // create a state isSubmitting to check if the form is submitting
  bool isSubmitting = false;

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Initialize RegExp outside of the function
final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}");
final RegExp phoneRegExp = RegExp(r"^\d{10}$");
final RegExp aadharRegExp = RegExp(r"^\d{12}$");
final RegExp passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$");

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}

Future<void> _loginUser() async {
  try {
    setState(() {
      isSubmitting = true;
    });

    AuthService authService = AuthService();

    String id = idController.text;
    String password = passwordController.text;
    String email = '';
    String phone = '';
    String aadharNumber = '';
    String pass = '';

    if (emailRegExp.hasMatch(id)) {
      email = id;
    } else if (phoneRegExp.hasMatch(id)) {
      phone = id;
    } else if (aadharRegExp.hasMatch(id)) {
      aadharNumber = id;
    } else {
      showSnackBar(context, "Invalid Email/ Phone/ Aadhar Number", Colors.red);
      return;
    }

    if (!passwordRegExp.hasMatch(password)) {
      showSnackBar(context, "Invalid Password", Colors.red);
      return;
    } else {
      pass = password;
    }

    var res = await authService.loginUser(
      email: email,
      phoneNumber: phone,
      aadharCardNumber: aadharNumber,
      password: pass,
    );

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
        showSnackBar(context, message, Colors.green);
      }
    } else {
      if (context.mounted) {
        showSnackBar(context, message, Colors.red);
      }
    }
  } catch (e) {
    if (context.mounted){
    showSnackBar(context, "An error occurred: $e", Colors.red);
    }
  } finally {
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
                height: 50,
              ),
              const Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              // Email/Phone/Aadhar Number  Field
              TextField(
                controller: idController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  fillColor: Color(0xff545560),
                  filled: true,
                  hintText: "Email/ Phone/ AadharNumber",
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
              TextField(
                controller: passwordController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: Colors.white,
                obscureText: true, // Add this line
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
                onTap: _loginUser,
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
                              "Log In",
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
                height: 20,
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
                height: 20,
              ),
              // Sign Up Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  );
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
                        "Sign Up",
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
