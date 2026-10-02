import 'package:flutter/material.dart';

import 'experience_calc.dart';

/// Five large buttons labelled 1 to 5 with their word labels.
class RatingButtons extends StatelessWidget {
  const RatingButtons({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final int? value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var r = 1; r <= 5; r++)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Semantics(
              button: true,
              selected: value == r,
              label: '$r, ${ratingLabels[r]}',
              child: ExcludeSemantics(
                child: (value == r ? FilledButton.new : OutlinedButton.new)(
                  style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(0, 64)),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 2),
                    ),
                  ),
                  onPressed: () => onChanged(r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$r',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ratingLabels[r]!,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        softWrap: false,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
