import 'package:flutter/material.dart';

class Challenge {
  final String date;
  final String dueDate;
  final String title;
  final String description;

  Challenge({
    @required this.date,
    @required this.title,
    this.dueDate,
    this.description,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      date: json['date'] as String,
      dueDate: json['dueDate'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String,String> toMap(){
    return {
      'date':date,
      'dueDate':dueDate,
      'description':description,
      'title':title,
    };
  }
}
