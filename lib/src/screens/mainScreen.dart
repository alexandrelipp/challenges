import 'package:flutter/material.dart';
import '../models/challenge.dart';
import 'package:provider/provider.dart';
import '../providers/challenges_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/challengeTile.dart';
import '../widgets/addChallenge.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final challengeProvider = Provider.of<ChallengesProvider>(context);
    return Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
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
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.docs.isEmpty) {
              return const Center(
                  child: Text('You have no challenges. Try adding one!'));
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                final challenge = Challenge.fromJson(document.data());
                return ChallengeTile(challenge);
              }).toList(),
            );
          },
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => context.read<ChallengesProvider>().signOut(),
                child: Icon(
                  Icons.logout,
                  size: 30,
                ),
              ),
            ),
          ),
          Spacer(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            margin: EdgeInsets.all(5),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 50, top: 15, bottom: 15, left: 20),
              child: Text(
                'Your challenges',
              ),
            ),
          )
        ],
      ),
    );
  }
}
