import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/challenge.dart';
import '../providers/challenges_provider.dart';
import '../widgets/addChallenge.dart';
import '../widgets/challengeTile.dart';
import '../widgets/customAppBar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final challengeProvider = Provider.of<ChallengesProvider>(context);
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return AddChallenge();
                });
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: challengeProvider.userChallenges,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text(
                  'You have no challenges.\n Try adding one!',
                  style: TextStyle(color: Colors.orange[800], fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ChallengesProvider>().triggerRebuild();
              },
              child: ListView(
                children: [
                  ...snapshot.data.docs.map((DocumentSnapshot document) {
                    final challenge =
                        Challenge.fromJson(document.data(), document.id);
                    return ChallengeTile(challenge);
                  }).toList(),
                  const SizedBox(height: 100)
                ],
              ),
            );
          },
        ));
  }
}
