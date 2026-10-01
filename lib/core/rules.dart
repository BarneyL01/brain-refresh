/// Confidence choices: 50-95 in steps of 5, plus 99.
const confidenceChoices = [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 99];
const defaultConfidence = 70;

/// Confidence (and journal reasoning) lock this long after creation.
const lockAfter = Duration(hours: 24);

bool isLocked(DateTime createdAt, DateTime now) =>
    now.difference(createdAt) >= lockAfter;

const outcomeTrue = 'true';
const outcomeFalse = 'false';
const outcomeVoid = 'void';

/// A prediction is due when open and its resolve-by date is today or earlier.
bool isDue(String? outcome, String resolveBy, String today) =>
    outcome == null && resolveBy.compareTo(today) <= 0;
