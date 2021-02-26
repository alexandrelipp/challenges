import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Challenge {
  final DateTime startDate;
  final DateTime dueDate;
  final String title;
  final String id;

  Challenge({
    @required this.id,
    @required this.startDate,
    @required this.title,
    this.dueDate,
  });

  factory Challenge.fromJson(Map<String, dynamic> json, String id) {
    return Challenge(
      id: id,
      startDate: (json['startDate'] as Timestamp).toDate(),
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      title: json['title'] as String,
    );
  }
}
