import 'package:flutter/material.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';

class PhaseModel {
  final String? startDate;
  final String phase;
  final int? day;
  final Color phaseColor;
  PhaseModel({
    required this.phase,
    this.day,
    this.phaseColor = kRedColour,
    this.startDate,
  });

  factory PhaseModel.fromJson(Map<String, dynamic> json) {
    return PhaseModel(
      day: json['day'],
      startDate: json['start_date'],
      phase: json['phase'],
      phaseColor: getPaseColor(json['phase']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start_date': startDate,
      'phase': phase,
    };
  }
  static Color getPaseColor(String pase) {
    switch (pase) {
      case 'Menstrual':
        return kRedColour;
      case 'Follicular':
        return kLightBlueColour;
      case 'Ovulation':
        return kGreenColour;
      case 'Luteal':
        return kMustardColour;
      default:
        return kAppColor;
    }
  }

  @override
  String toString() {
    return 'Phase{startDate: $startDate, phase: $phase, day: $day, phaseColor: $phaseColor}';
  }
}
