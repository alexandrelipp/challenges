import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Challenge {
  final DateTime startDate;
  final DateTime dueDate;
  final String title;

  Challenge({
    @required this.startDate,
    @required this.title,
    this.dueDate,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      startDate: (json['startDate'] as Timestamp).toDate(),
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      title: json['title'] as String,
    );
  }
}
