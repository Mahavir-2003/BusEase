import 'package:bus_ease/models/date.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

List<String> days = [
  'SUN',
  'MON',
  'TUE',
  'WED',
  'THU',
  'FRI',
  'SAT',
];

List<Date> dates = List<Date>.generate(31, (i) => Date(
  day: i + 1,
  isUpCompleted: i % 7 != 0,
  isDownCompleted: i % 7 != 0,
  isHoliday: i % 7 == 0,
));


class PassCalander extends StatefulWidget {
  const PassCalander({super.key});

  @override
  createState() => _PassCalanderState();
}

class _PassCalanderState extends State<PassCalander> {
  @override
  Widget build(BuildContext context) {
    // return a white container with a height of 200
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'UP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // a yellow box
                      Container(
                        height: 7,
                        width: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xffFBC420),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "JULY 2024",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'DOWN',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // a yellow box
                      Container(
                        height: 7,
                        width: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xff19C956),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    transform: Matrix4.translationValues(-10, 0, 0),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xff383E48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Expanded(
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 3.0,
                      dashLength: 7.0,
                      dashColor:  Color(0xff383E48),
                      dashRadius: 0.0,
                      dashGapLength: 5.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    )
                  ),
                  Container(
                    transform: Matrix4.translationValues(10, 0, 0),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xff383E48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: days.map((day) {
                  return Text(
                    day,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0 , bottom: 8),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 7,
                // render the days list
                children: dates.map((date) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: date.isHoliday ? Colors.red : Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 7,
                              width: 13,
                              decoration: BoxDecoration(
                                color: date.isUpCompleted || date.isHoliday ? const Color(0xffFBC420) : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 7,
                              width: 13,
                              decoration: BoxDecoration(
                                color: date.isDownCompleted || date.isHoliday ? const Color(0xff19C956) : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
      
  }
}