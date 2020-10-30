import 'package:flutter/material.dart';

class ChoiceMenu {
  const ChoiceMenu({this.title, this.icon, this.enabled, this.route});
  final String title;
  final IconData icon;
  final bool enabled;
  final String route;
}
