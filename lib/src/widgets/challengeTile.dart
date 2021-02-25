import 'dart:math';

import 'package:flutter/material.dart';
import '../models/challenge.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChallengeTile extends StatelessWidget {
  double progress;
  final Challenge challenge;
  bool done;
  ChallengeTile(this.challenge)
      : done = DateTime.now().isAfter(challenge.dueDate);

  @override
  Widget build(BuildContext context) {
    if (!done) {
      final challengeDurationHours =
          max((challenge.startDate.difference(challenge.dueDate)).inHours, 1);
      final completedHours =
          (DateTime.now().difference(challenge.startDate)).inHours;
      progress = min((completedHours / challengeDurationHours).abs(),1);
      print(challengeDurationHours);
      print(completedHours);
      print(progress);
    }
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.blueGrey[600],
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                challenge.title.toString() ?? 'a title',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              // Text(challenge.date ?? 'a date')
            ),
            !done
                ? CircularPercentIndicator(
                    backgroundWidth: 3,
                    progressColor: Theme.of(context)
                        .accentColor
                        .withOpacity(min(progress + 0.3, 1)),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    backgroundColor: Colors.blueGrey[800],
                    percent: progress,
                    radius: 40,
                    lineWidth: 8,
                  )
                : Icon(
                    Icons.check,
                    size: 40,
                    color: Theme.of(context).accentColor,
                  ),
          ],
        ),
      ),
    );
  }
}
