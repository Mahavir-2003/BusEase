import 'dart:convert';

import 'package:bus_ease/screens/ticket/ticket_create.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isCameraPaused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (!isCameraPaused) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383E48),
      appBar: AppBar(
        backgroundColor: const Color(0xff383E48),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth;
                      double scannerWidth = maxWidth * 0.7;
                      double scannerHeight = scannerWidth / 0.5;
                      return SizedBox(
                        width: scannerWidth,
                        height: scannerHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              QRView(
                                key: qrKey,
                                onQRViewCreated: _onQRViewCreated,
                                overlay: QrScannerOverlayShape(
                                  borderColor:
                                      const Color.fromARGB(255, 252, 231, 48),
                                  borderRadius: 10,
                                  borderLength: scannerHeight * 0.1,
                                  borderWidth: scannerHeight * 0.01,
                                  cutOutSize: scannerHeight * 0.5,
                                ),
                              ),
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    double verticalPosition;
                                    if (_animation.value < 0.5) {
                                      verticalPosition = _animation.value *
                                          2 *
                                          scannerHeight *
                                          0.5;
                                    } else {
                                      verticalPosition =
                                          (1 - (_animation.value - 0.5) * 2) *
                                              scannerHeight *
                                              0.5;
                                    }
                                    return Center(
                                      child: Container(
                                        height: 2,
                                        width: scannerWidth * 0.98,
                                        margin: EdgeInsets.only(
                                          top: verticalPosition,
                                          bottom: scannerHeight * 0.5 -
                                              verticalPosition,
                                        ),
                                        color: Colors.yellow,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // handle scanned data here
      // check if QR data contains the bus_number field in json data
      // if yes, then navigate to the ticket screen with the bus_number
      // QR code creation String : '{"bus_number" : "GJ-02-FT-1234","organization_name":"BusEase"}'
      // get both bus_number and organization_name from the scanned data

      // check if the scanned data is a valid json
      try {
        Map<String, dynamic> jsonData = jsonDecode(scanData.code ?? '');
        if (jsonData.containsKey('bus_number')) {
          String busNumber = jsonData['bus_number'];
          String organizationName = jsonData['organization_name'];

          if (busNumber.length == 13 &&
              busNumber.contains('-') &&
              busNumber.split('-').length == 4 &&
              organizationName.isNotEmpty &&
              organizationName == "BusEase") {
            // navigate to the ticket screen with the bus_number
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketCreate(bus_number: busNumber),
              ),
            ).then((value) {
              // resume the camera when you come back to the QRScanner page
              if (isCameraPaused) {
                controller.resumeCamera();
                isCameraPaused = false;
              }
            });
            // pause the camera after navigating to the next screen
            controller.pauseCamera();
            isCameraPaused = true;
          } else {
            print('Invalid QR code');
          }
        }
      } catch (e) {
        print('Invalid QR code');
      }
    });
  }
}
