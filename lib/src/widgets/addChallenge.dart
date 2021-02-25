import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_challenges/src/models/challenge.dart';
import 'package:intl/intl.dart';

import '../providers/challenges_provider.dart';

class AddChallenge extends StatefulWidget {
  @override
  _AddChallengeState createState() => _AddChallengeState();
}

class _AddChallengeState extends State<AddChallenge> {
  TextEditingController _controller;
  String title;
  DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.blueGrey[700],
      child: Column(
        children: [
          Text(
            'New Challenge!',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Title',
              //labelText: 'Title',
              prefixIcon: Icon(Icons.title),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          const Spacer(),
          RaisedButton(
            child: Text('Select Date'),
            onPressed: () => _selectDate(context),
          ),
          if (_selectedDate != null)
            Text(
              'Selected Date: ${DateFormat('d MMMM y').format(_selectedDate)}',
              style: TextStyle(color: Colors.white),
            ),
          const Spacer(),
          RaisedButton(
            color: Theme.of(context).accentColor,
            //disabledColor: Colors.black,
            onPressed:
                _controller.text.isEmpty || _controller.text.length >= 100
                    ? null
                    : () {
                        context.read<ChallengesProvider>().addChallenge(
                              _controller.text,
                              _selectedDate ??
                                  DateTime.now().add(
                                    Duration(days: 7),
                                  ),
                            );
                        Navigator.of(context).pop();
                      },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              child: Text(
                'Add challenge',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
