import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../src/providers/challenges_provider.dart';
import '../src/screens/mainScreen.dart';
import '../src/screens/authScreen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChallengesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.adaminaTextTheme(),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data as User;
            if (user != null) {
              context.read<ChallengesProvider>().uid = user.uid;
              return MainScreen();
            }
            context.read<ChallengesProvider>().uid = null;
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
