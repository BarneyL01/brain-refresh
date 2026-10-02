import 'package:drift/drift.dart';

part 'database.g.dart';

mixin Stamps on Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Tags extends Table with Stamps {
  TextColumn get name => text().unique()();
}

class Predictions extends Table with Stamps {
  TextColumn get statement => text()();
  IntColumn get confidence => integer()();
  TextColumn get resolveBy => text()();
  IntColumn get tagId => integer().nullable()();

  /// 'true', 'false' or 'void'. Null means open.
  TextColumn get outcome => text().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  IntColumn get journalEntryId => integer().nullable()();
}

class PredictionDateChanges extends Table with Stamps {
  IntColumn get predictionId => integer()();
  TextColumn get oldDate => text()();
  TextColumn get newDate => text()();
}

class JournalEntries extends Table with Stamps {
  TextColumn get decision => text()();
  TextColumn get context => text().nullable()();
  IntColumn get choiceOptionId => integer().nullable()();
  TextColumn get reasoning => text()();
  TextColumn get expectedOutcome => text()();
  IntColumn get confidence => integer()();
  IntColumn get tagId => integer().nullable()();
  TextColumn get reviewDate => text()();
}

class JournalOptions extends Table with Stamps {
  IntColumn get entryId => integer()();
  TextColumn get body => text().named('text')();
  IntColumn get sortOrder => integer()();
}

class JournalReviews extends Table with Stamps {
  IntColumn get entryId => integer().unique()();
  TextColumn get whatHappened => text()();
  IntColumn get reasoningScore => integer()();
  TextColumn get lessons => text().nullable()();
  DateTimeColumn get reviewedAt => dateTime()();
}

class DayPlans extends Table with Stamps {
  TextColumn get date => text().unique()();
}

class DayPlanTasks extends Table with Stamps {
  IntColumn get dayPlanId => integer()();
  TextColumn get body => text().named('text')();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer()();
}

class DayPlanDefaults extends Table with Stamps {
  IntColumn get dayPlanId => integer()();
  TextColumn get label => text()();
  TextColumn get choice => text()();
  IntColumn get sortOrder => integer()();
}

class OpenLoops extends Table with Stamps {
  TextColumn get body => text().named('text')();
  TextColumn get openedOn => text()();
  TextColumn get closedOn => text().nullable()();
  IntColumn get sourceTaskId => integer().nullable()();
}

class Shutdowns extends Table with Stamps {
  TextColumn get date => text().unique()();
  TextColumn get firstStep => text()();
  DateTimeColumn get closedAt => dateTime().nullable()();
}

class WinddownSteps extends Table with Stamps {
  TextColumn get name => text()();
  IntColumn get minutes => integer().nullable()();
  IntColumn get sortOrder => integer()();
}

class WinddownRuns extends Table with Stamps {
  TextColumn get date => text()();
  DateTimeColumn get startedAt => dateTime()();

  /// JSON array of step names.
  TextColumn get completedStepNames => text()();
}

/// Something with a start and an end that the user may judge later.
class Experiences extends Table with Stamps {
  TextColumn get name => text()();
  TextColumn get startDate => text()();
  TextColumn get endDate => text().nullable()();

  /// 'active' or 'finished'.
  TextColumn get status => text().withDefault(const Constant('active'))();

  /// 'daily', 'session' or 'manual'.
  TextColumn get checkinFrequency =>
      text().withDefault(const Constant('manual'))();
  DateTimeColumn get finishedAt => dateTime().nullable()();

  /// Days to wait after finishing before asking for the remembered rating.
  IntColumn get rememberAfterDays => integer().withDefault(const Constant(7))();
  IntColumn get rememberedRating => integer().nullable()();
  DateTimeColumn get rememberedRatingAt => dateTime().nullable()();

  /// 'yes', 'no' or 'yes_with_changes'.
  TextColumn get repeatDecision => text().nullable()();
  TextColumn get repeatNotes => text().nullable()();
}

class ExperienceParticipants extends Table with Stamps {
  IntColumn get experienceId => integer()();
  TextColumn get displayName => text()();
}

class CheckIns extends Table with Stamps {
  IntColumn get experienceId => integer()();

  /// Null means the main user.
  IntColumn get participantId => integer().nullable()();
  IntColumn get rating => integer()();
  TextColumn get note => text().nullable()();

  /// 'none', 'high' or 'low'.
  TextColumn get marker => text().withDefault(const Constant('none'))();

  /// When the check-in applies to. Editable, unlike createdAt.
  DateTimeColumn get checkedAt => dateTime()();
}

@DriftDatabase(
  tables: [
    Tags,
    Predictions,
    PredictionDateChanges,
    JournalEntries,
    JournalOptions,
    JournalReviews,
    DayPlans,
    DayPlanTasks,
    DayPlanDefaults,
    OpenLoops,
    Shutdowns,
    WinddownSteps,
    WinddownRuns,
    Experiences,
    ExperienceParticipants,
    CheckIns,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Increment on every table change and add a step to [migration].
  static const int currentSchemaVersion = 2;

  @override
  int get schemaVersion => currentSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(experiences);
        await m.createTable(experienceParticipants);
        await m.createTable(checkIns);
      }
    },
  );
}
