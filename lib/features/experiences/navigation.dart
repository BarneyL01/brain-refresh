import 'package:flutter/material.dart';

import '../../data/database.dart';
import 'experience_screen.dart';
import 'look_back_screen.dart';

/// Opens an experience: the live view while active or waiting for the
/// remembered rating, otherwise the Look back screen.
void openExperience(BuildContext context, Experience e) {
  final lookBack = e.status == 'finished' && e.rememberedRating != null;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          lookBack ? LookBackScreen(id: e.id) : ExperienceScreen(id: e.id),
    ),
  );
}
