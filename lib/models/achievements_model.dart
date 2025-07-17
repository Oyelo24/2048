import 'package:flutter/material.dart';

enum AchievementType { stage, badge }

class Achievement {
  final AchievementType type;
  final String title;
  final String? name;
  final String description;
  final IconData icon;

  const Achievement(
      {required this.type,
      required this.title,
      this.name,
      required this.description,
      required this.icon});
}

