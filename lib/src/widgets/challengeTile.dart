import 'package:flutter/material.dart';
import '../models/challenge.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChallengeTile extends StatelessWidget {
  final Challenge challenge;

  const ChallengeTile(this.challenge);
  @override
  Widget build(BuildContext context) {
    //TODO show progression bar
    return Card(
      color: Colors.blue[900],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[600],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  challenge.title ?? 'a title',
                  style: TextStyle(color: Colors.white),
                ),
                Text(challenge.date ?? 'a date')
              ],
            ),
            CircularPercentIndicator(
              center: Text('80%'),
              animation: true,
              progressColor: Colors.lightGreen[900],
              percent: 0.8,
              radius: 40,
              lineWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
