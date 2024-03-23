import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();

  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;

  bool _isHovered1 = false;
  bool _isHovered2 = false;
  bool _isHovered3 = false;

  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();

    _focusNode1.addListener(() {
      setState(() {
        _isHovered1 = _focusNode1.hasFocus;
      });
    });

    _focusNode2.addListener(() {
      setState(() {
        _isHovered2 = _focusNode2.hasFocus;
      });
    });

    _focusNode3.addListener(() {
      setState(() {
        _isHovered3 = _focusNode3.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  Widget buildTextField(String hintText, TextEditingController controller,
      FocusNode focusNode, bool isHovered) {
    TextStyle textStyle = const TextStyle(
      color: Colors.grey,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(84, 85, 96, 96),
                  border: Border.all(
                    color: isHovered ? Colors.white : Colors.transparent,
                    width: isHovered ? 1.0 : 0.0,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: textStyle,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    alignLabelWithHint: true,
                    isDense: true,
                    prefixIconConstraints: const BoxConstraints(minHeight: 48),
                  ),
                  focusNode: focusNode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383E48),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Full Name',
                      style: TextStyle(
                        color: Color.fromARGB(82, 214, 215, 215),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              buildTextField('Enter Full Name', _textEditingController1,
                  _focusNode1, _isHovered1),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Aadharcard Number',
                      style: TextStyle(
                        color: Color.fromARGB(82, 214, 215, 215),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              buildTextField('Aadharcard Number', _textEditingController2,
                  _focusNode2, _isHovered2),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'DOB',
                      style: TextStyle(
                        color: Color.fromARGB(82, 214, 215, 215),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              buildTextField(
                  'DOB', _textEditingController3, _focusNode3, _isHovered3),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenNavigator(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: const Color(0xffFBC420),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 14), // Equal vertical padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
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