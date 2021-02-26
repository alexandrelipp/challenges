import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/challenge.dart';
import '../providers/challenges_provider.dart';



class ChallengeTile extends StatelessWidget {
  int daysLeft;
  double progress;
  final Challenge challenge;
  bool done;
  ChallengeTile(this.challenge)
      : done = DateTime.now().isAfter(challenge.dueDate);

  @override
  Widget build(BuildContext context) {
    if (!done) {
      final challengeDurationHours =
          challenge.startDate.difference(challenge.dueDate).inHours;
      final completedHours =
          (DateTime.now().difference(challenge.startDate)).inHours;
      progress = min((completedHours / challengeDurationHours).abs(), 1);
      daysLeft = challenge.dueDate.difference(DateTime.now()).inDays + 1;
    }
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) => Container(
                color: Colors.blueGrey[800],
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      challenge.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    RaisedButton(
                      color: Colors.red[900],
                      child: const Text(
                        'Delete Challenge',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        context
                            .read<ChallengesProvider>()
                            .deleteChallenge(challenge.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                // Text(challenge.date ?? 'a date')
              ),
              Builder(
                builder: (context) {
                  if (!done) {
                    return Column(
                      children: [
                        CircularPercentIndicator(
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
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$daysLeft ${daysLeft == 1 ? 'day' : 'days'} left',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
                  return Icon(
                    Icons.check,
                    size: 40,
                    color: Theme.of(context).accentColor,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
