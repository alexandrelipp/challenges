import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_challenges/src/models/challenge.dart';

import '../providers/challenges_provider.dart';

class AddChallenge extends StatefulWidget {
  @override
  _AddChallengeState createState() => _AddChallengeState();
}

class _AddChallengeState extends State<AddChallenge> {
  final _formKey = GlobalKey<FormState>();
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (newValue) => title = newValue,
            ),
            RaisedButton(
              onPressed: () async {
                await context.read<ChallengesProvider>().addChallenge(title??'title was null');
                Navigator.of(context).pop();
              },
              child: Text('Add challenge'),
            )
          ],
        ),
      ),
    );
  }
}
