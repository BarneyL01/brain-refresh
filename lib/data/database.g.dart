// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  const Tag({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
    };
  }

  Tag copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
  }) => Tag(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PredictionsTable extends Predictions
    with TableInfo<$PredictionsTable, Prediction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statementMeta = const VerificationMeta(
    'statement',
  );
  @override
  late final GeneratedColumn<String> statement = GeneratedColumn<String>(
    'statement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<int> confidence = GeneratedColumn<int>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolveByMeta = const VerificationMeta(
    'resolveBy',
  );
  @override
  late final GeneratedColumn<String> resolveBy = GeneratedColumn<String>(
    'resolve_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _journalEntryIdMeta = const VerificationMeta(
    'journalEntryId',
  );
  @override
  late final GeneratedColumn<int> journalEntryId = GeneratedColumn<int>(
    'journal_entry_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    statement,
    confidence,
    resolveBy,
    tagId,
    outcome,
    resolvedAt,
    journalEntryId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'predictions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Prediction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('statement')) {
      context.handle(
        _statementMeta,
        statement.isAcceptableOrUnknown(data['statement']!, _statementMeta),
      );
    } else if (isInserting) {
      context.missing(_statementMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('resolve_by')) {
      context.handle(
        _resolveByMeta,
        resolveBy.isAcceptableOrUnknown(data['resolve_by']!, _resolveByMeta),
      );
    } else if (isInserting) {
      context.missing(_resolveByMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('journal_entry_id')) {
      context.handle(
        _journalEntryIdMeta,
        journalEntryId.isAcceptableOrUnknown(
          data['journal_entry_id']!,
          _journalEntryIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prediction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prediction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      statement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statement'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence'],
      )!,
      resolveBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolve_by'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      journalEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entry_id'],
      ),
    );
  }

  @override
  $PredictionsTable createAlias(String alias) {
    return $PredictionsTable(attachedDatabase, alias);
  }
}

class Prediction extends DataClass implements Insertable<Prediction> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String statement;
  final int confidence;
  final String resolveBy;
  final int? tagId;

  /// 'true', 'false' or 'void'. Null means open.
  final String? outcome;
  final DateTime? resolvedAt;
  final int? journalEntryId;
  const Prediction({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.statement,
    required this.confidence,
    required this.resolveBy,
    this.tagId,
    this.outcome,
    this.resolvedAt,
    this.journalEntryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['statement'] = Variable<String>(statement);
    map['confidence'] = Variable<int>(confidence);
    map['resolve_by'] = Variable<String>(resolveBy);
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || journalEntryId != null) {
      map['journal_entry_id'] = Variable<int>(journalEntryId);
    }
    return map;
  }

  PredictionsCompanion toCompanion(bool nullToAbsent) {
    return PredictionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      statement: Value(statement),
      confidence: Value(confidence),
      resolveBy: Value(resolveBy),
      tagId: tagId == null && nullToAbsent
          ? const Value.absent()
          : Value(tagId),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      journalEntryId: journalEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(journalEntryId),
    );
  }

  factory Prediction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prediction(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      statement: serializer.fromJson<String>(json['statement']),
      confidence: serializer.fromJson<int>(json['confidence']),
      resolveBy: serializer.fromJson<String>(json['resolveBy']),
      tagId: serializer.fromJson<int?>(json['tagId']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      journalEntryId: serializer.fromJson<int?>(json['journalEntryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'statement': serializer.toJson<String>(statement),
      'confidence': serializer.toJson<int>(confidence),
      'resolveBy': serializer.toJson<String>(resolveBy),
      'tagId': serializer.toJson<int?>(tagId),
      'outcome': serializer.toJson<String?>(outcome),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'journalEntryId': serializer.toJson<int?>(journalEntryId),
    };
  }

  Prediction copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? statement,
    int? confidence,
    String? resolveBy,
    Value<int?> tagId = const Value.absent(),
    Value<String?> outcome = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<int?> journalEntryId = const Value.absent(),
  }) => Prediction(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    statement: statement ?? this.statement,
    confidence: confidence ?? this.confidence,
    resolveBy: resolveBy ?? this.resolveBy,
    tagId: tagId.present ? tagId.value : this.tagId,
    outcome: outcome.present ? outcome.value : this.outcome,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    journalEntryId: journalEntryId.present
        ? journalEntryId.value
        : this.journalEntryId,
  );
  Prediction copyWithCompanion(PredictionsCompanion data) {
    return Prediction(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      statement: data.statement.present ? data.statement.value : this.statement,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      resolveBy: data.resolveBy.present ? data.resolveBy.value : this.resolveBy,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      journalEntryId: data.journalEntryId.present
          ? data.journalEntryId.value
          : this.journalEntryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prediction(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('statement: $statement, ')
          ..write('confidence: $confidence, ')
          ..write('resolveBy: $resolveBy, ')
          ..write('tagId: $tagId, ')
          ..write('outcome: $outcome, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('journalEntryId: $journalEntryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    statement,
    confidence,
    resolveBy,
    tagId,
    outcome,
    resolvedAt,
    journalEntryId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prediction &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.statement == this.statement &&
          other.confidence == this.confidence &&
          other.resolveBy == this.resolveBy &&
          other.tagId == this.tagId &&
          other.outcome == this.outcome &&
          other.resolvedAt == this.resolvedAt &&
          other.journalEntryId == this.journalEntryId);
}

class PredictionsCompanion extends UpdateCompanion<Prediction> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> statement;
  final Value<int> confidence;
  final Value<String> resolveBy;
  final Value<int?> tagId;
  final Value<String?> outcome;
  final Value<DateTime?> resolvedAt;
  final Value<int?> journalEntryId;
  const PredictionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.statement = const Value.absent(),
    this.confidence = const Value.absent(),
    this.resolveBy = const Value.absent(),
    this.tagId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.journalEntryId = const Value.absent(),
  });
  PredictionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String statement,
    required int confidence,
    required String resolveBy,
    this.tagId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.journalEntryId = const Value.absent(),
  }) : statement = Value(statement),
       confidence = Value(confidence),
       resolveBy = Value(resolveBy);
  static Insertable<Prediction> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? statement,
    Expression<int>? confidence,
    Expression<String>? resolveBy,
    Expression<int>? tagId,
    Expression<String>? outcome,
    Expression<DateTime>? resolvedAt,
    Expression<int>? journalEntryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (statement != null) 'statement': statement,
      if (confidence != null) 'confidence': confidence,
      if (resolveBy != null) 'resolve_by': resolveBy,
      if (tagId != null) 'tag_id': tagId,
      if (outcome != null) 'outcome': outcome,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (journalEntryId != null) 'journal_entry_id': journalEntryId,
    });
  }

  PredictionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? statement,
    Value<int>? confidence,
    Value<String>? resolveBy,
    Value<int?>? tagId,
    Value<String?>? outcome,
    Value<DateTime?>? resolvedAt,
    Value<int?>? journalEntryId,
  }) {
    return PredictionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      statement: statement ?? this.statement,
      confidence: confidence ?? this.confidence,
      resolveBy: resolveBy ?? this.resolveBy,
      tagId: tagId ?? this.tagId,
      outcome: outcome ?? this.outcome,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      journalEntryId: journalEntryId ?? this.journalEntryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (statement.present) {
      map['statement'] = Variable<String>(statement.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<int>(confidence.value);
    }
    if (resolveBy.present) {
      map['resolve_by'] = Variable<String>(resolveBy.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (journalEntryId.present) {
      map['journal_entry_id'] = Variable<int>(journalEntryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('statement: $statement, ')
          ..write('confidence: $confidence, ')
          ..write('resolveBy: $resolveBy, ')
          ..write('tagId: $tagId, ')
          ..write('outcome: $outcome, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('journalEntryId: $journalEntryId')
          ..write(')'))
        .toString();
  }
}

class $PredictionDateChangesTable extends PredictionDateChanges
    with TableInfo<$PredictionDateChangesTable, PredictionDateChange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictionDateChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _predictionIdMeta = const VerificationMeta(
    'predictionId',
  );
  @override
  late final GeneratedColumn<int> predictionId = GeneratedColumn<int>(
    'prediction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldDateMeta = const VerificationMeta(
    'oldDate',
  );
  @override
  late final GeneratedColumn<String> oldDate = GeneratedColumn<String>(
    'old_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newDateMeta = const VerificationMeta(
    'newDate',
  );
  @override
  late final GeneratedColumn<String> newDate = GeneratedColumn<String>(
    'new_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    predictionId,
    oldDate,
    newDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prediction_date_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PredictionDateChange> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('prediction_id')) {
      context.handle(
        _predictionIdMeta,
        predictionId.isAcceptableOrUnknown(
          data['prediction_id']!,
          _predictionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_predictionIdMeta);
    }
    if (data.containsKey('old_date')) {
      context.handle(
        _oldDateMeta,
        oldDate.isAcceptableOrUnknown(data['old_date']!, _oldDateMeta),
      );
    } else if (isInserting) {
      context.missing(_oldDateMeta);
    }
    if (data.containsKey('new_date')) {
      context.handle(
        _newDateMeta,
        newDate.isAcceptableOrUnknown(data['new_date']!, _newDateMeta),
      );
    } else if (isInserting) {
      context.missing(_newDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PredictionDateChange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PredictionDateChange(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      predictionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prediction_id'],
      )!,
      oldDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_date'],
      )!,
      newDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_date'],
      )!,
    );
  }

  @override
  $PredictionDateChangesTable createAlias(String alias) {
    return $PredictionDateChangesTable(attachedDatabase, alias);
  }
}

class PredictionDateChange extends DataClass
    implements Insertable<PredictionDateChange> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int predictionId;
  final String oldDate;
  final String newDate;
  const PredictionDateChange({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.predictionId,
    required this.oldDate,
    required this.newDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['prediction_id'] = Variable<int>(predictionId);
    map['old_date'] = Variable<String>(oldDate);
    map['new_date'] = Variable<String>(newDate);
    return map;
  }

  PredictionDateChangesCompanion toCompanion(bool nullToAbsent) {
    return PredictionDateChangesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      predictionId: Value(predictionId),
      oldDate: Value(oldDate),
      newDate: Value(newDate),
    );
  }

  factory PredictionDateChange.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PredictionDateChange(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      predictionId: serializer.fromJson<int>(json['predictionId']),
      oldDate: serializer.fromJson<String>(json['oldDate']),
      newDate: serializer.fromJson<String>(json['newDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'predictionId': serializer.toJson<int>(predictionId),
      'oldDate': serializer.toJson<String>(oldDate),
      'newDate': serializer.toJson<String>(newDate),
    };
  }

  PredictionDateChange copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? predictionId,
    String? oldDate,
    String? newDate,
  }) => PredictionDateChange(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    predictionId: predictionId ?? this.predictionId,
    oldDate: oldDate ?? this.oldDate,
    newDate: newDate ?? this.newDate,
  );
  PredictionDateChange copyWithCompanion(PredictionDateChangesCompanion data) {
    return PredictionDateChange(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      predictionId: data.predictionId.present
          ? data.predictionId.value
          : this.predictionId,
      oldDate: data.oldDate.present ? data.oldDate.value : this.oldDate,
      newDate: data.newDate.present ? data.newDate.value : this.newDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PredictionDateChange(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('predictionId: $predictionId, ')
          ..write('oldDate: $oldDate, ')
          ..write('newDate: $newDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, predictionId, oldDate, newDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PredictionDateChange &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.predictionId == this.predictionId &&
          other.oldDate == this.oldDate &&
          other.newDate == this.newDate);
}

class PredictionDateChangesCompanion
    extends UpdateCompanion<PredictionDateChange> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> predictionId;
  final Value<String> oldDate;
  final Value<String> newDate;
  const PredictionDateChangesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.predictionId = const Value.absent(),
    this.oldDate = const Value.absent(),
    this.newDate = const Value.absent(),
  });
  PredictionDateChangesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int predictionId,
    required String oldDate,
    required String newDate,
  }) : predictionId = Value(predictionId),
       oldDate = Value(oldDate),
       newDate = Value(newDate);
  static Insertable<PredictionDateChange> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? predictionId,
    Expression<String>? oldDate,
    Expression<String>? newDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (predictionId != null) 'prediction_id': predictionId,
      if (oldDate != null) 'old_date': oldDate,
      if (newDate != null) 'new_date': newDate,
    });
  }

  PredictionDateChangesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? predictionId,
    Value<String>? oldDate,
    Value<String>? newDate,
  }) {
    return PredictionDateChangesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      predictionId: predictionId ?? this.predictionId,
      oldDate: oldDate ?? this.oldDate,
      newDate: newDate ?? this.newDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (predictionId.present) {
      map['prediction_id'] = Variable<int>(predictionId.value);
    }
    if (oldDate.present) {
      map['old_date'] = Variable<String>(oldDate.value);
    }
    if (newDate.present) {
      map['new_date'] = Variable<String>(newDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictionDateChangesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('predictionId: $predictionId, ')
          ..write('oldDate: $oldDate, ')
          ..write('newDate: $newDate')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextMeta = const VerificationMeta(
    'context',
  );
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
    'context',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _choiceOptionIdMeta = const VerificationMeta(
    'choiceOptionId',
  );
  @override
  late final GeneratedColumn<int> choiceOptionId = GeneratedColumn<int>(
    'choice_option_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reasoningMeta = const VerificationMeta(
    'reasoning',
  );
  @override
  late final GeneratedColumn<String> reasoning = GeneratedColumn<String>(
    'reasoning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedOutcomeMeta = const VerificationMeta(
    'expectedOutcome',
  );
  @override
  late final GeneratedColumn<String> expectedOutcome = GeneratedColumn<String>(
    'expected_outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<int> confidence = GeneratedColumn<int>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewDateMeta = const VerificationMeta(
    'reviewDate',
  );
  @override
  late final GeneratedColumn<String> reviewDate = GeneratedColumn<String>(
    'review_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    decision,
    context,
    choiceOptionId,
    reasoning,
    expectedOutcome,
    confidence,
    tagId,
    reviewDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('context')) {
      context.handle(
        _contextMeta,
        this.context.isAcceptableOrUnknown(data['context']!, _contextMeta),
      );
    }
    if (data.containsKey('choice_option_id')) {
      context.handle(
        _choiceOptionIdMeta,
        choiceOptionId.isAcceptableOrUnknown(
          data['choice_option_id']!,
          _choiceOptionIdMeta,
        ),
      );
    }
    if (data.containsKey('reasoning')) {
      context.handle(
        _reasoningMeta,
        reasoning.isAcceptableOrUnknown(data['reasoning']!, _reasoningMeta),
      );
    } else if (isInserting) {
      context.missing(_reasoningMeta);
    }
    if (data.containsKey('expected_outcome')) {
      context.handle(
        _expectedOutcomeMeta,
        expectedOutcome.isAcceptableOrUnknown(
          data['expected_outcome']!,
          _expectedOutcomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedOutcomeMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    }
    if (data.containsKey('review_date')) {
      context.handle(
        _reviewDateMeta,
        reviewDate.isAcceptableOrUnknown(data['review_date']!, _reviewDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      context: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context'],
      ),
      choiceOptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}choice_option_id'],
      ),
      reasoning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reasoning'],
      )!,
      expectedOutcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_outcome'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      ),
      reviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_date'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String decision;
  final String? context;
  final int? choiceOptionId;
  final String reasoning;
  final String expectedOutcome;
  final int confidence;
  final int? tagId;
  final String reviewDate;
  const JournalEntry({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.decision,
    this.context,
    this.choiceOptionId,
    required this.reasoning,
    required this.expectedOutcome,
    required this.confidence,
    this.tagId,
    required this.reviewDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['decision'] = Variable<String>(decision);
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    if (!nullToAbsent || choiceOptionId != null) {
      map['choice_option_id'] = Variable<int>(choiceOptionId);
    }
    map['reasoning'] = Variable<String>(reasoning);
    map['expected_outcome'] = Variable<String>(expectedOutcome);
    map['confidence'] = Variable<int>(confidence);
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    map['review_date'] = Variable<String>(reviewDate);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      decision: Value(decision),
      context: context == null && nullToAbsent
          ? const Value.absent()
          : Value(context),
      choiceOptionId: choiceOptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(choiceOptionId),
      reasoning: Value(reasoning),
      expectedOutcome: Value(expectedOutcome),
      confidence: Value(confidence),
      tagId: tagId == null && nullToAbsent
          ? const Value.absent()
          : Value(tagId),
      reviewDate: Value(reviewDate),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      decision: serializer.fromJson<String>(json['decision']),
      context: serializer.fromJson<String?>(json['context']),
      choiceOptionId: serializer.fromJson<int?>(json['choiceOptionId']),
      reasoning: serializer.fromJson<String>(json['reasoning']),
      expectedOutcome: serializer.fromJson<String>(json['expectedOutcome']),
      confidence: serializer.fromJson<int>(json['confidence']),
      tagId: serializer.fromJson<int?>(json['tagId']),
      reviewDate: serializer.fromJson<String>(json['reviewDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'decision': serializer.toJson<String>(decision),
      'context': serializer.toJson<String?>(context),
      'choiceOptionId': serializer.toJson<int?>(choiceOptionId),
      'reasoning': serializer.toJson<String>(reasoning),
      'expectedOutcome': serializer.toJson<String>(expectedOutcome),
      'confidence': serializer.toJson<int>(confidence),
      'tagId': serializer.toJson<int?>(tagId),
      'reviewDate': serializer.toJson<String>(reviewDate),
    };
  }

  JournalEntry copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? decision,
    Value<String?> context = const Value.absent(),
    Value<int?> choiceOptionId = const Value.absent(),
    String? reasoning,
    String? expectedOutcome,
    int? confidence,
    Value<int?> tagId = const Value.absent(),
    String? reviewDate,
  }) => JournalEntry(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    decision: decision ?? this.decision,
    context: context.present ? context.value : this.context,
    choiceOptionId: choiceOptionId.present
        ? choiceOptionId.value
        : this.choiceOptionId,
    reasoning: reasoning ?? this.reasoning,
    expectedOutcome: expectedOutcome ?? this.expectedOutcome,
    confidence: confidence ?? this.confidence,
    tagId: tagId.present ? tagId.value : this.tagId,
    reviewDate: reviewDate ?? this.reviewDate,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      decision: data.decision.present ? data.decision.value : this.decision,
      context: data.context.present ? data.context.value : this.context,
      choiceOptionId: data.choiceOptionId.present
          ? data.choiceOptionId.value
          : this.choiceOptionId,
      reasoning: data.reasoning.present ? data.reasoning.value : this.reasoning,
      expectedOutcome: data.expectedOutcome.present
          ? data.expectedOutcome.value
          : this.expectedOutcome,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      reviewDate: data.reviewDate.present
          ? data.reviewDate.value
          : this.reviewDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('decision: $decision, ')
          ..write('context: $context, ')
          ..write('choiceOptionId: $choiceOptionId, ')
          ..write('reasoning: $reasoning, ')
          ..write('expectedOutcome: $expectedOutcome, ')
          ..write('confidence: $confidence, ')
          ..write('tagId: $tagId, ')
          ..write('reviewDate: $reviewDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    decision,
    context,
    choiceOptionId,
    reasoning,
    expectedOutcome,
    confidence,
    tagId,
    reviewDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.decision == this.decision &&
          other.context == this.context &&
          other.choiceOptionId == this.choiceOptionId &&
          other.reasoning == this.reasoning &&
          other.expectedOutcome == this.expectedOutcome &&
          other.confidence == this.confidence &&
          other.tagId == this.tagId &&
          other.reviewDate == this.reviewDate);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> decision;
  final Value<String?> context;
  final Value<int?> choiceOptionId;
  final Value<String> reasoning;
  final Value<String> expectedOutcome;
  final Value<int> confidence;
  final Value<int?> tagId;
  final Value<String> reviewDate;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.decision = const Value.absent(),
    this.context = const Value.absent(),
    this.choiceOptionId = const Value.absent(),
    this.reasoning = const Value.absent(),
    this.expectedOutcome = const Value.absent(),
    this.confidence = const Value.absent(),
    this.tagId = const Value.absent(),
    this.reviewDate = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String decision,
    this.context = const Value.absent(),
    this.choiceOptionId = const Value.absent(),
    required String reasoning,
    required String expectedOutcome,
    required int confidence,
    this.tagId = const Value.absent(),
    required String reviewDate,
  }) : decision = Value(decision),
       reasoning = Value(reasoning),
       expectedOutcome = Value(expectedOutcome),
       confidence = Value(confidence),
       reviewDate = Value(reviewDate);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? decision,
    Expression<String>? context,
    Expression<int>? choiceOptionId,
    Expression<String>? reasoning,
    Expression<String>? expectedOutcome,
    Expression<int>? confidence,
    Expression<int>? tagId,
    Expression<String>? reviewDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (decision != null) 'decision': decision,
      if (context != null) 'context': context,
      if (choiceOptionId != null) 'choice_option_id': choiceOptionId,
      if (reasoning != null) 'reasoning': reasoning,
      if (expectedOutcome != null) 'expected_outcome': expectedOutcome,
      if (confidence != null) 'confidence': confidence,
      if (tagId != null) 'tag_id': tagId,
      if (reviewDate != null) 'review_date': reviewDate,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? decision,
    Value<String?>? context,
    Value<int?>? choiceOptionId,
    Value<String>? reasoning,
    Value<String>? expectedOutcome,
    Value<int>? confidence,
    Value<int?>? tagId,
    Value<String>? reviewDate,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      decision: decision ?? this.decision,
      context: context ?? this.context,
      choiceOptionId: choiceOptionId ?? this.choiceOptionId,
      reasoning: reasoning ?? this.reasoning,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
      confidence: confidence ?? this.confidence,
      tagId: tagId ?? this.tagId,
      reviewDate: reviewDate ?? this.reviewDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (choiceOptionId.present) {
      map['choice_option_id'] = Variable<int>(choiceOptionId.value);
    }
    if (reasoning.present) {
      map['reasoning'] = Variable<String>(reasoning.value);
    }
    if (expectedOutcome.present) {
      map['expected_outcome'] = Variable<String>(expectedOutcome.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<int>(confidence.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (reviewDate.present) {
      map['review_date'] = Variable<String>(reviewDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('decision: $decision, ')
          ..write('context: $context, ')
          ..write('choiceOptionId: $choiceOptionId, ')
          ..write('reasoning: $reasoning, ')
          ..write('expectedOutcome: $expectedOutcome, ')
          ..write('confidence: $confidence, ')
          ..write('tagId: $tagId, ')
          ..write('reviewDate: $reviewDate')
          ..write(')'))
        .toString();
  }
}

class $JournalOptionsTable extends JournalOptions
    with TableInfo<$JournalOptionsTable, JournalOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    entryId,
    body,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['text']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $JournalOptionsTable createAlias(String alias) {
    return $JournalOptionsTable(attachedDatabase, alias);
  }
}

class JournalOption extends DataClass implements Insertable<JournalOption> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int entryId;
  final String body;
  final int sortOrder;
  const JournalOption({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.entryId,
    required this.body,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['entry_id'] = Variable<int>(entryId);
    map['text'] = Variable<String>(body);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  JournalOptionsCompanion toCompanion(bool nullToAbsent) {
    return JournalOptionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      entryId: Value(entryId),
      body: Value(body),
      sortOrder: Value(sortOrder),
    );
  }

  factory JournalOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalOption(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      entryId: serializer.fromJson<int>(json['entryId']),
      body: serializer.fromJson<String>(json['body']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'entryId': serializer.toJson<int>(entryId),
      'body': serializer.toJson<String>(body),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  JournalOption copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? entryId,
    String? body,
    int? sortOrder,
  }) => JournalOption(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    entryId: entryId ?? this.entryId,
    body: body ?? this.body,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  JournalOption copyWithCompanion(JournalOptionsCompanion data) {
    return JournalOption(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      body: data.body.present ? data.body.value : this.body,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalOption(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('entryId: $entryId, ')
          ..write('body: $body, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, entryId, body, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalOption &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.entryId == this.entryId &&
          other.body == this.body &&
          other.sortOrder == this.sortOrder);
}

class JournalOptionsCompanion extends UpdateCompanion<JournalOption> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> entryId;
  final Value<String> body;
  final Value<int> sortOrder;
  const JournalOptionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.entryId = const Value.absent(),
    this.body = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  JournalOptionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int entryId,
    required String body,
    required int sortOrder,
  }) : entryId = Value(entryId),
       body = Value(body),
       sortOrder = Value(sortOrder);
  static Insertable<JournalOption> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? entryId,
    Expression<String>? body,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (entryId != null) 'entry_id': entryId,
      if (body != null) 'text': body,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  JournalOptionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? entryId,
    Value<String>? body,
    Value<int>? sortOrder,
  }) {
    return JournalOptionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      entryId: entryId ?? this.entryId,
      body: body ?? this.body,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (body.present) {
      map['text'] = Variable<String>(body.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalOptionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('entryId: $entryId, ')
          ..write('body: $body, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $JournalReviewsTable extends JournalReviews
    with TableInfo<$JournalReviewsTable, JournalReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _whatHappenedMeta = const VerificationMeta(
    'whatHappened',
  );
  @override
  late final GeneratedColumn<String> whatHappened = GeneratedColumn<String>(
    'what_happened',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasoningScoreMeta = const VerificationMeta(
    'reasoningScore',
  );
  @override
  late final GeneratedColumn<int> reasoningScore = GeneratedColumn<int>(
    'reasoning_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonsMeta = const VerificationMeta(
    'lessons',
  );
  @override
  late final GeneratedColumn<String> lessons = GeneratedColumn<String>(
    'lessons',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    entryId,
    whatHappened,
    reasoningScore,
    lessons,
    reviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('what_happened')) {
      context.handle(
        _whatHappenedMeta,
        whatHappened.isAcceptableOrUnknown(
          data['what_happened']!,
          _whatHappenedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_whatHappenedMeta);
    }
    if (data.containsKey('reasoning_score')) {
      context.handle(
        _reasoningScoreMeta,
        reasoningScore.isAcceptableOrUnknown(
          data['reasoning_score']!,
          _reasoningScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reasoningScoreMeta);
    }
    if (data.containsKey('lessons')) {
      context.handle(
        _lessonsMeta,
        lessons.isAcceptableOrUnknown(data['lessons']!, _lessonsMeta),
      );
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalReview(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      whatHappened: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}what_happened'],
      )!,
      reasoningScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reasoning_score'],
      )!,
      lessons: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lessons'],
      ),
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
    );
  }

  @override
  $JournalReviewsTable createAlias(String alias) {
    return $JournalReviewsTable(attachedDatabase, alias);
  }
}

class JournalReview extends DataClass implements Insertable<JournalReview> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int entryId;
  final String whatHappened;
  final int reasoningScore;
  final String? lessons;
  final DateTime reviewedAt;
  const JournalReview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.entryId,
    required this.whatHappened,
    required this.reasoningScore,
    this.lessons,
    required this.reviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['entry_id'] = Variable<int>(entryId);
    map['what_happened'] = Variable<String>(whatHappened);
    map['reasoning_score'] = Variable<int>(reasoningScore);
    if (!nullToAbsent || lessons != null) {
      map['lessons'] = Variable<String>(lessons);
    }
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    return map;
  }

  JournalReviewsCompanion toCompanion(bool nullToAbsent) {
    return JournalReviewsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      entryId: Value(entryId),
      whatHappened: Value(whatHappened),
      reasoningScore: Value(reasoningScore),
      lessons: lessons == null && nullToAbsent
          ? const Value.absent()
          : Value(lessons),
      reviewedAt: Value(reviewedAt),
    );
  }

  factory JournalReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalReview(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      entryId: serializer.fromJson<int>(json['entryId']),
      whatHappened: serializer.fromJson<String>(json['whatHappened']),
      reasoningScore: serializer.fromJson<int>(json['reasoningScore']),
      lessons: serializer.fromJson<String?>(json['lessons']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'entryId': serializer.toJson<int>(entryId),
      'whatHappened': serializer.toJson<String>(whatHappened),
      'reasoningScore': serializer.toJson<int>(reasoningScore),
      'lessons': serializer.toJson<String?>(lessons),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
    };
  }

  JournalReview copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? entryId,
    String? whatHappened,
    int? reasoningScore,
    Value<String?> lessons = const Value.absent(),
    DateTime? reviewedAt,
  }) => JournalReview(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    entryId: entryId ?? this.entryId,
    whatHappened: whatHappened ?? this.whatHappened,
    reasoningScore: reasoningScore ?? this.reasoningScore,
    lessons: lessons.present ? lessons.value : this.lessons,
    reviewedAt: reviewedAt ?? this.reviewedAt,
  );
  JournalReview copyWithCompanion(JournalReviewsCompanion data) {
    return JournalReview(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      whatHappened: data.whatHappened.present
          ? data.whatHappened.value
          : this.whatHappened,
      reasoningScore: data.reasoningScore.present
          ? data.reasoningScore.value
          : this.reasoningScore,
      lessons: data.lessons.present ? data.lessons.value : this.lessons,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalReview(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('entryId: $entryId, ')
          ..write('whatHappened: $whatHappened, ')
          ..write('reasoningScore: $reasoningScore, ')
          ..write('lessons: $lessons, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    entryId,
    whatHappened,
    reasoningScore,
    lessons,
    reviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalReview &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.entryId == this.entryId &&
          other.whatHappened == this.whatHappened &&
          other.reasoningScore == this.reasoningScore &&
          other.lessons == this.lessons &&
          other.reviewedAt == this.reviewedAt);
}

class JournalReviewsCompanion extends UpdateCompanion<JournalReview> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> entryId;
  final Value<String> whatHappened;
  final Value<int> reasoningScore;
  final Value<String?> lessons;
  final Value<DateTime> reviewedAt;
  const JournalReviewsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.entryId = const Value.absent(),
    this.whatHappened = const Value.absent(),
    this.reasoningScore = const Value.absent(),
    this.lessons = const Value.absent(),
    this.reviewedAt = const Value.absent(),
  });
  JournalReviewsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int entryId,
    required String whatHappened,
    required int reasoningScore,
    this.lessons = const Value.absent(),
    required DateTime reviewedAt,
  }) : entryId = Value(entryId),
       whatHappened = Value(whatHappened),
       reasoningScore = Value(reasoningScore),
       reviewedAt = Value(reviewedAt);
  static Insertable<JournalReview> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? entryId,
    Expression<String>? whatHappened,
    Expression<int>? reasoningScore,
    Expression<String>? lessons,
    Expression<DateTime>? reviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (entryId != null) 'entry_id': entryId,
      if (whatHappened != null) 'what_happened': whatHappened,
      if (reasoningScore != null) 'reasoning_score': reasoningScore,
      if (lessons != null) 'lessons': lessons,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
    });
  }

  JournalReviewsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? entryId,
    Value<String>? whatHappened,
    Value<int>? reasoningScore,
    Value<String?>? lessons,
    Value<DateTime>? reviewedAt,
  }) {
    return JournalReviewsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      entryId: entryId ?? this.entryId,
      whatHappened: whatHappened ?? this.whatHappened,
      reasoningScore: reasoningScore ?? this.reasoningScore,
      lessons: lessons ?? this.lessons,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (whatHappened.present) {
      map['what_happened'] = Variable<String>(whatHappened.value);
    }
    if (reasoningScore.present) {
      map['reasoning_score'] = Variable<int>(reasoningScore.value);
    }
    if (lessons.present) {
      map['lessons'] = Variable<String>(lessons.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalReviewsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('entryId: $entryId, ')
          ..write('whatHappened: $whatHappened, ')
          ..write('reasoningScore: $reasoningScore, ')
          ..write('lessons: $lessons, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }
}

class $DayPlansTable extends DayPlans with TableInfo<$DayPlansTable, DayPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $DayPlansTable createAlias(String alias) {
    return $DayPlansTable(attachedDatabase, alias);
  }
}

class DayPlan extends DataClass implements Insertable<DayPlan> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String date;
  const DayPlan({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['date'] = Variable<String>(date);
    return map;
  }

  DayPlansCompanion toCompanion(bool nullToAbsent) {
    return DayPlansCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      date: Value(date),
    );
  }

  factory DayPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayPlan(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'date': serializer.toJson<String>(date),
    };
  }

  DayPlan copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? date,
  }) => DayPlan(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    date: date ?? this.date,
  );
  DayPlan copyWithCompanion(DayPlansCompanion data) {
    return DayPlan(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayPlan(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayPlan &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.date == this.date);
}

class DayPlansCompanion extends UpdateCompanion<DayPlan> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> date;
  const DayPlansCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.date = const Value.absent(),
  });
  DayPlansCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String date,
  }) : date = Value(date);
  static Insertable<DayPlan> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (date != null) 'date': date,
    });
  }

  DayPlansCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? date,
  }) {
    return DayPlansCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayPlansCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DayPlanTasksTable extends DayPlanTasks
    with TableInfo<$DayPlanTasksTable, DayPlanTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayPlanTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dayPlanIdMeta = const VerificationMeta(
    'dayPlanId',
  );
  @override
  late final GeneratedColumn<int> dayPlanId = GeneratedColumn<int>(
    'day_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    dayPlanId,
    body,
    done,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_plan_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayPlanTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('day_plan_id')) {
      context.handle(
        _dayPlanIdMeta,
        dayPlanId.isAcceptableOrUnknown(data['day_plan_id']!, _dayPlanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dayPlanIdMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['text']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayPlanTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayPlanTask(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      dayPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_plan_id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DayPlanTasksTable createAlias(String alias) {
    return $DayPlanTasksTable(attachedDatabase, alias);
  }
}

class DayPlanTask extends DataClass implements Insertable<DayPlanTask> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int dayPlanId;
  final String body;
  final bool done;
  final int sortOrder;
  const DayPlanTask({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.dayPlanId,
    required this.body,
    required this.done,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['day_plan_id'] = Variable<int>(dayPlanId);
    map['text'] = Variable<String>(body);
    map['done'] = Variable<bool>(done);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DayPlanTasksCompanion toCompanion(bool nullToAbsent) {
    return DayPlanTasksCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      dayPlanId: Value(dayPlanId),
      body: Value(body),
      done: Value(done),
      sortOrder: Value(sortOrder),
    );
  }

  factory DayPlanTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayPlanTask(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      dayPlanId: serializer.fromJson<int>(json['dayPlanId']),
      body: serializer.fromJson<String>(json['body']),
      done: serializer.fromJson<bool>(json['done']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'dayPlanId': serializer.toJson<int>(dayPlanId),
      'body': serializer.toJson<String>(body),
      'done': serializer.toJson<bool>(done),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DayPlanTask copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? dayPlanId,
    String? body,
    bool? done,
    int? sortOrder,
  }) => DayPlanTask(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    dayPlanId: dayPlanId ?? this.dayPlanId,
    body: body ?? this.body,
    done: done ?? this.done,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DayPlanTask copyWithCompanion(DayPlanTasksCompanion data) {
    return DayPlanTask(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dayPlanId: data.dayPlanId.present ? data.dayPlanId.value : this.dayPlanId,
      body: data.body.present ? data.body.value : this.body,
      done: data.done.present ? data.done.value : this.done,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayPlanTask(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dayPlanId: $dayPlanId, ')
          ..write('body: $body, ')
          ..write('done: $done, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, dayPlanId, body, done, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayPlanTask &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.dayPlanId == this.dayPlanId &&
          other.body == this.body &&
          other.done == this.done &&
          other.sortOrder == this.sortOrder);
}

class DayPlanTasksCompanion extends UpdateCompanion<DayPlanTask> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> dayPlanId;
  final Value<String> body;
  final Value<bool> done;
  final Value<int> sortOrder;
  const DayPlanTasksCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dayPlanId = const Value.absent(),
    this.body = const Value.absent(),
    this.done = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  DayPlanTasksCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int dayPlanId,
    required String body,
    this.done = const Value.absent(),
    required int sortOrder,
  }) : dayPlanId = Value(dayPlanId),
       body = Value(body),
       sortOrder = Value(sortOrder);
  static Insertable<DayPlanTask> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? dayPlanId,
    Expression<String>? body,
    Expression<bool>? done,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dayPlanId != null) 'day_plan_id': dayPlanId,
      if (body != null) 'text': body,
      if (done != null) 'done': done,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  DayPlanTasksCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? dayPlanId,
    Value<String>? body,
    Value<bool>? done,
    Value<int>? sortOrder,
  }) {
    return DayPlanTasksCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dayPlanId: dayPlanId ?? this.dayPlanId,
      body: body ?? this.body,
      done: done ?? this.done,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (dayPlanId.present) {
      map['day_plan_id'] = Variable<int>(dayPlanId.value);
    }
    if (body.present) {
      map['text'] = Variable<String>(body.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayPlanTasksCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dayPlanId: $dayPlanId, ')
          ..write('body: $body, ')
          ..write('done: $done, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $DayPlanDefaultsTable extends DayPlanDefaults
    with TableInfo<$DayPlanDefaultsTable, DayPlanDefault> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayPlanDefaultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dayPlanIdMeta = const VerificationMeta(
    'dayPlanId',
  );
  @override
  late final GeneratedColumn<int> dayPlanId = GeneratedColumn<int>(
    'day_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _choiceMeta = const VerificationMeta('choice');
  @override
  late final GeneratedColumn<String> choice = GeneratedColumn<String>(
    'choice',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    dayPlanId,
    label,
    choice,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_plan_defaults';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayPlanDefault> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('day_plan_id')) {
      context.handle(
        _dayPlanIdMeta,
        dayPlanId.isAcceptableOrUnknown(data['day_plan_id']!, _dayPlanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dayPlanIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('choice')) {
      context.handle(
        _choiceMeta,
        choice.isAcceptableOrUnknown(data['choice']!, _choiceMeta),
      );
    } else if (isInserting) {
      context.missing(_choiceMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayPlanDefault map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayPlanDefault(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      dayPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_plan_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      choice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}choice'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DayPlanDefaultsTable createAlias(String alias) {
    return $DayPlanDefaultsTable(attachedDatabase, alias);
  }
}

class DayPlanDefault extends DataClass implements Insertable<DayPlanDefault> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int dayPlanId;
  final String label;
  final String choice;
  final int sortOrder;
  const DayPlanDefault({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.dayPlanId,
    required this.label,
    required this.choice,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['day_plan_id'] = Variable<int>(dayPlanId);
    map['label'] = Variable<String>(label);
    map['choice'] = Variable<String>(choice);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DayPlanDefaultsCompanion toCompanion(bool nullToAbsent) {
    return DayPlanDefaultsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      dayPlanId: Value(dayPlanId),
      label: Value(label),
      choice: Value(choice),
      sortOrder: Value(sortOrder),
    );
  }

  factory DayPlanDefault.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayPlanDefault(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      dayPlanId: serializer.fromJson<int>(json['dayPlanId']),
      label: serializer.fromJson<String>(json['label']),
      choice: serializer.fromJson<String>(json['choice']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'dayPlanId': serializer.toJson<int>(dayPlanId),
      'label': serializer.toJson<String>(label),
      'choice': serializer.toJson<String>(choice),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DayPlanDefault copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? dayPlanId,
    String? label,
    String? choice,
    int? sortOrder,
  }) => DayPlanDefault(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    dayPlanId: dayPlanId ?? this.dayPlanId,
    label: label ?? this.label,
    choice: choice ?? this.choice,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DayPlanDefault copyWithCompanion(DayPlanDefaultsCompanion data) {
    return DayPlanDefault(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dayPlanId: data.dayPlanId.present ? data.dayPlanId.value : this.dayPlanId,
      label: data.label.present ? data.label.value : this.label,
      choice: data.choice.present ? data.choice.value : this.choice,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayPlanDefault(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dayPlanId: $dayPlanId, ')
          ..write('label: $label, ')
          ..write('choice: $choice, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    dayPlanId,
    label,
    choice,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayPlanDefault &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.dayPlanId == this.dayPlanId &&
          other.label == this.label &&
          other.choice == this.choice &&
          other.sortOrder == this.sortOrder);
}

class DayPlanDefaultsCompanion extends UpdateCompanion<DayPlanDefault> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> dayPlanId;
  final Value<String> label;
  final Value<String> choice;
  final Value<int> sortOrder;
  const DayPlanDefaultsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dayPlanId = const Value.absent(),
    this.label = const Value.absent(),
    this.choice = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  DayPlanDefaultsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int dayPlanId,
    required String label,
    required String choice,
    required int sortOrder,
  }) : dayPlanId = Value(dayPlanId),
       label = Value(label),
       choice = Value(choice),
       sortOrder = Value(sortOrder);
  static Insertable<DayPlanDefault> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? dayPlanId,
    Expression<String>? label,
    Expression<String>? choice,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dayPlanId != null) 'day_plan_id': dayPlanId,
      if (label != null) 'label': label,
      if (choice != null) 'choice': choice,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  DayPlanDefaultsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? dayPlanId,
    Value<String>? label,
    Value<String>? choice,
    Value<int>? sortOrder,
  }) {
    return DayPlanDefaultsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dayPlanId: dayPlanId ?? this.dayPlanId,
      label: label ?? this.label,
      choice: choice ?? this.choice,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (dayPlanId.present) {
      map['day_plan_id'] = Variable<int>(dayPlanId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (choice.present) {
      map['choice'] = Variable<String>(choice.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayPlanDefaultsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dayPlanId: $dayPlanId, ')
          ..write('label: $label, ')
          ..write('choice: $choice, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $OpenLoopsTable extends OpenLoops
    with TableInfo<$OpenLoopsTable, OpenLoop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OpenLoopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedOnMeta = const VerificationMeta(
    'openedOn',
  );
  @override
  late final GeneratedColumn<String> openedOn = GeneratedColumn<String>(
    'opened_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedOnMeta = const VerificationMeta(
    'closedOn',
  );
  @override
  late final GeneratedColumn<String> closedOn = GeneratedColumn<String>(
    'closed_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTaskIdMeta = const VerificationMeta(
    'sourceTaskId',
  );
  @override
  late final GeneratedColumn<int> sourceTaskId = GeneratedColumn<int>(
    'source_task_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    body,
    openedOn,
    closedOn,
    sourceTaskId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'open_loops';
  @override
  VerificationContext validateIntegrity(
    Insertable<OpenLoop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('text')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['text']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('opened_on')) {
      context.handle(
        _openedOnMeta,
        openedOn.isAcceptableOrUnknown(data['opened_on']!, _openedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_openedOnMeta);
    }
    if (data.containsKey('closed_on')) {
      context.handle(
        _closedOnMeta,
        closedOn.isAcceptableOrUnknown(data['closed_on']!, _closedOnMeta),
      );
    }
    if (data.containsKey('source_task_id')) {
      context.handle(
        _sourceTaskIdMeta,
        sourceTaskId.isAcceptableOrUnknown(
          data['source_task_id']!,
          _sourceTaskIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OpenLoop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OpenLoop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      openedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opened_on'],
      )!,
      closedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closed_on'],
      ),
      sourceTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_task_id'],
      ),
    );
  }

  @override
  $OpenLoopsTable createAlias(String alias) {
    return $OpenLoopsTable(attachedDatabase, alias);
  }
}

class OpenLoop extends DataClass implements Insertable<OpenLoop> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final String openedOn;
  final String? closedOn;
  final int? sourceTaskId;
  const OpenLoop({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.openedOn,
    this.closedOn,
    this.sourceTaskId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['text'] = Variable<String>(body);
    map['opened_on'] = Variable<String>(openedOn);
    if (!nullToAbsent || closedOn != null) {
      map['closed_on'] = Variable<String>(closedOn);
    }
    if (!nullToAbsent || sourceTaskId != null) {
      map['source_task_id'] = Variable<int>(sourceTaskId);
    }
    return map;
  }

  OpenLoopsCompanion toCompanion(bool nullToAbsent) {
    return OpenLoopsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      body: Value(body),
      openedOn: Value(openedOn),
      closedOn: closedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(closedOn),
      sourceTaskId: sourceTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceTaskId),
    );
  }

  factory OpenLoop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OpenLoop(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      body: serializer.fromJson<String>(json['body']),
      openedOn: serializer.fromJson<String>(json['openedOn']),
      closedOn: serializer.fromJson<String?>(json['closedOn']),
      sourceTaskId: serializer.fromJson<int?>(json['sourceTaskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'body': serializer.toJson<String>(body),
      'openedOn': serializer.toJson<String>(openedOn),
      'closedOn': serializer.toJson<String?>(closedOn),
      'sourceTaskId': serializer.toJson<int?>(sourceTaskId),
    };
  }

  OpenLoop copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? body,
    String? openedOn,
    Value<String?> closedOn = const Value.absent(),
    Value<int?> sourceTaskId = const Value.absent(),
  }) => OpenLoop(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    body: body ?? this.body,
    openedOn: openedOn ?? this.openedOn,
    closedOn: closedOn.present ? closedOn.value : this.closedOn,
    sourceTaskId: sourceTaskId.present ? sourceTaskId.value : this.sourceTaskId,
  );
  OpenLoop copyWithCompanion(OpenLoopsCompanion data) {
    return OpenLoop(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      body: data.body.present ? data.body.value : this.body,
      openedOn: data.openedOn.present ? data.openedOn.value : this.openedOn,
      closedOn: data.closedOn.present ? data.closedOn.value : this.closedOn,
      sourceTaskId: data.sourceTaskId.present
          ? data.sourceTaskId.value
          : this.sourceTaskId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OpenLoop(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('body: $body, ')
          ..write('openedOn: $openedOn, ')
          ..write('closedOn: $closedOn, ')
          ..write('sourceTaskId: $sourceTaskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    body,
    openedOn,
    closedOn,
    sourceTaskId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OpenLoop &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.body == this.body &&
          other.openedOn == this.openedOn &&
          other.closedOn == this.closedOn &&
          other.sourceTaskId == this.sourceTaskId);
}

class OpenLoopsCompanion extends UpdateCompanion<OpenLoop> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> body;
  final Value<String> openedOn;
  final Value<String?> closedOn;
  final Value<int?> sourceTaskId;
  const OpenLoopsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.body = const Value.absent(),
    this.openedOn = const Value.absent(),
    this.closedOn = const Value.absent(),
    this.sourceTaskId = const Value.absent(),
  });
  OpenLoopsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String body,
    required String openedOn,
    this.closedOn = const Value.absent(),
    this.sourceTaskId = const Value.absent(),
  }) : body = Value(body),
       openedOn = Value(openedOn);
  static Insertable<OpenLoop> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? body,
    Expression<String>? openedOn,
    Expression<String>? closedOn,
    Expression<int>? sourceTaskId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (body != null) 'text': body,
      if (openedOn != null) 'opened_on': openedOn,
      if (closedOn != null) 'closed_on': closedOn,
      if (sourceTaskId != null) 'source_task_id': sourceTaskId,
    });
  }

  OpenLoopsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? body,
    Value<String>? openedOn,
    Value<String?>? closedOn,
    Value<int?>? sourceTaskId,
  }) {
    return OpenLoopsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      body: body ?? this.body,
      openedOn: openedOn ?? this.openedOn,
      closedOn: closedOn ?? this.closedOn,
      sourceTaskId: sourceTaskId ?? this.sourceTaskId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (body.present) {
      map['text'] = Variable<String>(body.value);
    }
    if (openedOn.present) {
      map['opened_on'] = Variable<String>(openedOn.value);
    }
    if (closedOn.present) {
      map['closed_on'] = Variable<String>(closedOn.value);
    }
    if (sourceTaskId.present) {
      map['source_task_id'] = Variable<int>(sourceTaskId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OpenLoopsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('body: $body, ')
          ..write('openedOn: $openedOn, ')
          ..write('closedOn: $closedOn, ')
          ..write('sourceTaskId: $sourceTaskId')
          ..write(')'))
        .toString();
  }
}

class $ShutdownsTable extends Shutdowns
    with TableInfo<$ShutdownsTable, Shutdown> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShutdownsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _firstStepMeta = const VerificationMeta(
    'firstStep',
  );
  @override
  late final GeneratedColumn<String> firstStep = GeneratedColumn<String>(
    'first_step',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    date,
    firstStep,
    closedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shutdowns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shutdown> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('first_step')) {
      context.handle(
        _firstStepMeta,
        firstStep.isAcceptableOrUnknown(data['first_step']!, _firstStepMeta),
      );
    } else if (isInserting) {
      context.missing(_firstStepMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shutdown map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shutdown(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      firstStep: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_step'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
    );
  }

  @override
  $ShutdownsTable createAlias(String alias) {
    return $ShutdownsTable(attachedDatabase, alias);
  }
}

class Shutdown extends DataClass implements Insertable<Shutdown> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String date;
  final String firstStep;
  final DateTime? closedAt;
  const Shutdown({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.firstStep,
    this.closedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['date'] = Variable<String>(date);
    map['first_step'] = Variable<String>(firstStep);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    return map;
  }

  ShutdownsCompanion toCompanion(bool nullToAbsent) {
    return ShutdownsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      date: Value(date),
      firstStep: Value(firstStep),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
    );
  }

  factory Shutdown.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shutdown(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      date: serializer.fromJson<String>(json['date']),
      firstStep: serializer.fromJson<String>(json['firstStep']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'date': serializer.toJson<String>(date),
      'firstStep': serializer.toJson<String>(firstStep),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
    };
  }

  Shutdown copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? date,
    String? firstStep,
    Value<DateTime?> closedAt = const Value.absent(),
  }) => Shutdown(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    date: date ?? this.date,
    firstStep: firstStep ?? this.firstStep,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
  );
  Shutdown copyWithCompanion(ShutdownsCompanion data) {
    return Shutdown(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      date: data.date.present ? data.date.value : this.date,
      firstStep: data.firstStep.present ? data.firstStep.value : this.firstStep,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shutdown(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('firstStep: $firstStep, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, date, firstStep, closedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shutdown &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.date == this.date &&
          other.firstStep == this.firstStep &&
          other.closedAt == this.closedAt);
}

class ShutdownsCompanion extends UpdateCompanion<Shutdown> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> date;
  final Value<String> firstStep;
  final Value<DateTime?> closedAt;
  const ShutdownsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.firstStep = const Value.absent(),
    this.closedAt = const Value.absent(),
  });
  ShutdownsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String date,
    required String firstStep,
    this.closedAt = const Value.absent(),
  }) : date = Value(date),
       firstStep = Value(firstStep);
  static Insertable<Shutdown> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? date,
    Expression<String>? firstStep,
    Expression<DateTime>? closedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (date != null) 'date': date,
      if (firstStep != null) 'first_step': firstStep,
      if (closedAt != null) 'closed_at': closedAt,
    });
  }

  ShutdownsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? date,
    Value<String>? firstStep,
    Value<DateTime?>? closedAt,
  }) {
    return ShutdownsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      firstStep: firstStep ?? this.firstStep,
      closedAt: closedAt ?? this.closedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (firstStep.present) {
      map['first_step'] = Variable<String>(firstStep.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShutdownsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('firstStep: $firstStep, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }
}

class $WinddownStepsTable extends WinddownSteps
    with TableInfo<$WinddownStepsTable, WinddownStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WinddownStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    minutes,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'winddown_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<WinddownStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WinddownStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WinddownStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $WinddownStepsTable createAlias(String alias) {
    return $WinddownStepsTable(attachedDatabase, alias);
  }
}

class WinddownStep extends DataClass implements Insertable<WinddownStep> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final int? minutes;
  final int sortOrder;
  const WinddownStep({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.minutes,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || minutes != null) {
      map['minutes'] = Variable<int>(minutes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  WinddownStepsCompanion toCompanion(bool nullToAbsent) {
    return WinddownStepsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      minutes: minutes == null && nullToAbsent
          ? const Value.absent()
          : Value(minutes),
      sortOrder: Value(sortOrder),
    );
  }

  factory WinddownStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WinddownStep(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      minutes: serializer.fromJson<int?>(json['minutes']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'minutes': serializer.toJson<int?>(minutes),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  WinddownStep copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    Value<int?> minutes = const Value.absent(),
    int? sortOrder,
  }) => WinddownStep(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    minutes: minutes.present ? minutes.value : this.minutes,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  WinddownStep copyWithCompanion(WinddownStepsCompanion data) {
    return WinddownStep(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WinddownStep(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('minutes: $minutes, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, name, minutes, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WinddownStep &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.minutes == this.minutes &&
          other.sortOrder == this.sortOrder);
}

class WinddownStepsCompanion extends UpdateCompanion<WinddownStep> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<int?> minutes;
  final Value<int> sortOrder;
  const WinddownStepsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.minutes = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  WinddownStepsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    this.minutes = const Value.absent(),
    required int sortOrder,
  }) : name = Value(name),
       sortOrder = Value(sortOrder);
  static Insertable<WinddownStep> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<int>? minutes,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (minutes != null) 'minutes': minutes,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  WinddownStepsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<int?>? minutes,
    Value<int>? sortOrder,
  }) {
    return WinddownStepsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      minutes: minutes ?? this.minutes,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WinddownStepsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('minutes: $minutes, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $WinddownRunsTable extends WinddownRuns
    with TableInfo<$WinddownRunsTable, WinddownRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WinddownRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedStepNamesMeta =
      const VerificationMeta('completedStepNames');
  @override
  late final GeneratedColumn<String> completedStepNames =
      GeneratedColumn<String>(
        'completed_step_names',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    date,
    startedAt,
    completedStepNames,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'winddown_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WinddownRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_step_names')) {
      context.handle(
        _completedStepNamesMeta,
        completedStepNames.isAcceptableOrUnknown(
          data['completed_step_names']!,
          _completedStepNamesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedStepNamesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WinddownRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WinddownRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedStepNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_step_names'],
      )!,
    );
  }

  @override
  $WinddownRunsTable createAlias(String alias) {
    return $WinddownRunsTable(attachedDatabase, alias);
  }
}

class WinddownRun extends DataClass implements Insertable<WinddownRun> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String date;
  final DateTime startedAt;

  /// JSON array of step names.
  final String completedStepNames;
  const WinddownRun({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.startedAt,
    required this.completedStepNames,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['date'] = Variable<String>(date);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['completed_step_names'] = Variable<String>(completedStepNames);
    return map;
  }

  WinddownRunsCompanion toCompanion(bool nullToAbsent) {
    return WinddownRunsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      date: Value(date),
      startedAt: Value(startedAt),
      completedStepNames: Value(completedStepNames),
    );
  }

  factory WinddownRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WinddownRun(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      date: serializer.fromJson<String>(json['date']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedStepNames: serializer.fromJson<String>(
        json['completedStepNames'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'date': serializer.toJson<String>(date),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedStepNames': serializer.toJson<String>(completedStepNames),
    };
  }

  WinddownRun copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? date,
    DateTime? startedAt,
    String? completedStepNames,
  }) => WinddownRun(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    date: date ?? this.date,
    startedAt: startedAt ?? this.startedAt,
    completedStepNames: completedStepNames ?? this.completedStepNames,
  );
  WinddownRun copyWithCompanion(WinddownRunsCompanion data) {
    return WinddownRun(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      date: data.date.present ? data.date.value : this.date,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedStepNames: data.completedStepNames.present
          ? data.completedStepNames.value
          : this.completedStepNames,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WinddownRun(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedStepNames: $completedStepNames')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    date,
    startedAt,
    completedStepNames,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WinddownRun &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.date == this.date &&
          other.startedAt == this.startedAt &&
          other.completedStepNames == this.completedStepNames);
}

class WinddownRunsCompanion extends UpdateCompanion<WinddownRun> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> date;
  final Value<DateTime> startedAt;
  final Value<String> completedStepNames;
  const WinddownRunsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedStepNames = const Value.absent(),
  });
  WinddownRunsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String date,
    required DateTime startedAt,
    required String completedStepNames,
  }) : date = Value(date),
       startedAt = Value(startedAt),
       completedStepNames = Value(completedStepNames);
  static Insertable<WinddownRun> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? date,
    Expression<DateTime>? startedAt,
    Expression<String>? completedStepNames,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (date != null) 'date': date,
      if (startedAt != null) 'started_at': startedAt,
      if (completedStepNames != null)
        'completed_step_names': completedStepNames,
    });
  }

  WinddownRunsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? date,
    Value<DateTime>? startedAt,
    Value<String>? completedStepNames,
  }) {
    return WinddownRunsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      startedAt: startedAt ?? this.startedAt,
      completedStepNames: completedStepNames ?? this.completedStepNames,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedStepNames.present) {
      map['completed_step_names'] = Variable<String>(completedStepNames.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WinddownRunsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedStepNames: $completedStepNames')
          ..write(')'))
        .toString();
  }
}

class $ExperiencesTable extends Experiences
    with TableInfo<$ExperiencesTable, Experience> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperiencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _checkinFrequencyMeta = const VerificationMeta(
    'checkinFrequency',
  );
  @override
  late final GeneratedColumn<String> checkinFrequency = GeneratedColumn<String>(
    'checkin_frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rememberAfterDaysMeta = const VerificationMeta(
    'rememberAfterDays',
  );
  @override
  late final GeneratedColumn<int> rememberAfterDays = GeneratedColumn<int>(
    'remember_after_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _rememberedRatingMeta = const VerificationMeta(
    'rememberedRating',
  );
  @override
  late final GeneratedColumn<int> rememberedRating = GeneratedColumn<int>(
    'remembered_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rememberedRatingAtMeta =
      const VerificationMeta('rememberedRatingAt');
  @override
  late final GeneratedColumn<DateTime> rememberedRatingAt =
      GeneratedColumn<DateTime>(
        'remembered_rating_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _repeatDecisionMeta = const VerificationMeta(
    'repeatDecision',
  );
  @override
  late final GeneratedColumn<String> repeatDecision = GeneratedColumn<String>(
    'repeat_decision',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatNotesMeta = const VerificationMeta(
    'repeatNotes',
  );
  @override
  late final GeneratedColumn<String> repeatNotes = GeneratedColumn<String>(
    'repeat_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    startDate,
    endDate,
    status,
    checkinFrequency,
    finishedAt,
    rememberAfterDays,
    rememberedRating,
    rememberedRatingAt,
    repeatDecision,
    repeatNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experiences';
  @override
  VerificationContext validateIntegrity(
    Insertable<Experience> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('checkin_frequency')) {
      context.handle(
        _checkinFrequencyMeta,
        checkinFrequency.isAcceptableOrUnknown(
          data['checkin_frequency']!,
          _checkinFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('remember_after_days')) {
      context.handle(
        _rememberAfterDaysMeta,
        rememberAfterDays.isAcceptableOrUnknown(
          data['remember_after_days']!,
          _rememberAfterDaysMeta,
        ),
      );
    }
    if (data.containsKey('remembered_rating')) {
      context.handle(
        _rememberedRatingMeta,
        rememberedRating.isAcceptableOrUnknown(
          data['remembered_rating']!,
          _rememberedRatingMeta,
        ),
      );
    }
    if (data.containsKey('remembered_rating_at')) {
      context.handle(
        _rememberedRatingAtMeta,
        rememberedRatingAt.isAcceptableOrUnknown(
          data['remembered_rating_at']!,
          _rememberedRatingAtMeta,
        ),
      );
    }
    if (data.containsKey('repeat_decision')) {
      context.handle(
        _repeatDecisionMeta,
        repeatDecision.isAcceptableOrUnknown(
          data['repeat_decision']!,
          _repeatDecisionMeta,
        ),
      );
    }
    if (data.containsKey('repeat_notes')) {
      context.handle(
        _repeatNotesMeta,
        repeatNotes.isAcceptableOrUnknown(
          data['repeat_notes']!,
          _repeatNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Experience map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Experience(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      checkinFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checkin_frequency'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      rememberAfterDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remember_after_days'],
      )!,
      rememberedRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remembered_rating'],
      ),
      rememberedRatingAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}remembered_rating_at'],
      ),
      repeatDecision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_decision'],
      ),
      repeatNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_notes'],
      ),
    );
  }

  @override
  $ExperiencesTable createAlias(String alias) {
    return $ExperiencesTable(attachedDatabase, alias);
  }
}

class Experience extends DataClass implements Insertable<Experience> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String startDate;
  final String? endDate;

  /// 'active' or 'finished'.
  final String status;

  /// 'daily', 'session' or 'manual'.
  final String checkinFrequency;
  final DateTime? finishedAt;

  /// Days to wait after finishing before asking for the remembered rating.
  final int rememberAfterDays;
  final int? rememberedRating;
  final DateTime? rememberedRatingAt;

  /// 'yes', 'no' or 'yes_with_changes'.
  final String? repeatDecision;
  final String? repeatNotes;
  const Experience({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.checkinFrequency,
    this.finishedAt,
    required this.rememberAfterDays,
    this.rememberedRating,
    this.rememberedRatingAt,
    this.repeatDecision,
    this.repeatNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['status'] = Variable<String>(status);
    map['checkin_frequency'] = Variable<String>(checkinFrequency);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['remember_after_days'] = Variable<int>(rememberAfterDays);
    if (!nullToAbsent || rememberedRating != null) {
      map['remembered_rating'] = Variable<int>(rememberedRating);
    }
    if (!nullToAbsent || rememberedRatingAt != null) {
      map['remembered_rating_at'] = Variable<DateTime>(rememberedRatingAt);
    }
    if (!nullToAbsent || repeatDecision != null) {
      map['repeat_decision'] = Variable<String>(repeatDecision);
    }
    if (!nullToAbsent || repeatNotes != null) {
      map['repeat_notes'] = Variable<String>(repeatNotes);
    }
    return map;
  }

  ExperiencesCompanion toCompanion(bool nullToAbsent) {
    return ExperiencesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      status: Value(status),
      checkinFrequency: Value(checkinFrequency),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      rememberAfterDays: Value(rememberAfterDays),
      rememberedRating: rememberedRating == null && nullToAbsent
          ? const Value.absent()
          : Value(rememberedRating),
      rememberedRatingAt: rememberedRatingAt == null && nullToAbsent
          ? const Value.absent()
          : Value(rememberedRatingAt),
      repeatDecision: repeatDecision == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatDecision),
      repeatNotes: repeatNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatNotes),
    );
  }

  factory Experience.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Experience(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      status: serializer.fromJson<String>(json['status']),
      checkinFrequency: serializer.fromJson<String>(json['checkinFrequency']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      rememberAfterDays: serializer.fromJson<int>(json['rememberAfterDays']),
      rememberedRating: serializer.fromJson<int?>(json['rememberedRating']),
      rememberedRatingAt: serializer.fromJson<DateTime?>(
        json['rememberedRatingAt'],
      ),
      repeatDecision: serializer.fromJson<String?>(json['repeatDecision']),
      repeatNotes: serializer.fromJson<String?>(json['repeatNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
      'status': serializer.toJson<String>(status),
      'checkinFrequency': serializer.toJson<String>(checkinFrequency),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'rememberAfterDays': serializer.toJson<int>(rememberAfterDays),
      'rememberedRating': serializer.toJson<int?>(rememberedRating),
      'rememberedRatingAt': serializer.toJson<DateTime?>(rememberedRatingAt),
      'repeatDecision': serializer.toJson<String?>(repeatDecision),
      'repeatNotes': serializer.toJson<String?>(repeatNotes),
    };
  }

  Experience copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? startDate,
    Value<String?> endDate = const Value.absent(),
    String? status,
    String? checkinFrequency,
    Value<DateTime?> finishedAt = const Value.absent(),
    int? rememberAfterDays,
    Value<int?> rememberedRating = const Value.absent(),
    Value<DateTime?> rememberedRatingAt = const Value.absent(),
    Value<String?> repeatDecision = const Value.absent(),
    Value<String?> repeatNotes = const Value.absent(),
  }) => Experience(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    status: status ?? this.status,
    checkinFrequency: checkinFrequency ?? this.checkinFrequency,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    rememberAfterDays: rememberAfterDays ?? this.rememberAfterDays,
    rememberedRating: rememberedRating.present
        ? rememberedRating.value
        : this.rememberedRating,
    rememberedRatingAt: rememberedRatingAt.present
        ? rememberedRatingAt.value
        : this.rememberedRatingAt,
    repeatDecision: repeatDecision.present
        ? repeatDecision.value
        : this.repeatDecision,
    repeatNotes: repeatNotes.present ? repeatNotes.value : this.repeatNotes,
  );
  Experience copyWithCompanion(ExperiencesCompanion data) {
    return Experience(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
      checkinFrequency: data.checkinFrequency.present
          ? data.checkinFrequency.value
          : this.checkinFrequency,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      rememberAfterDays: data.rememberAfterDays.present
          ? data.rememberAfterDays.value
          : this.rememberAfterDays,
      rememberedRating: data.rememberedRating.present
          ? data.rememberedRating.value
          : this.rememberedRating,
      rememberedRatingAt: data.rememberedRatingAt.present
          ? data.rememberedRatingAt.value
          : this.rememberedRatingAt,
      repeatDecision: data.repeatDecision.present
          ? data.repeatDecision.value
          : this.repeatDecision,
      repeatNotes: data.repeatNotes.present
          ? data.repeatNotes.value
          : this.repeatNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Experience(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('checkinFrequency: $checkinFrequency, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('rememberAfterDays: $rememberAfterDays, ')
          ..write('rememberedRating: $rememberedRating, ')
          ..write('rememberedRatingAt: $rememberedRatingAt, ')
          ..write('repeatDecision: $repeatDecision, ')
          ..write('repeatNotes: $repeatNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    startDate,
    endDate,
    status,
    checkinFrequency,
    finishedAt,
    rememberAfterDays,
    rememberedRating,
    rememberedRatingAt,
    repeatDecision,
    repeatNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Experience &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status &&
          other.checkinFrequency == this.checkinFrequency &&
          other.finishedAt == this.finishedAt &&
          other.rememberAfterDays == this.rememberAfterDays &&
          other.rememberedRating == this.rememberedRating &&
          other.rememberedRatingAt == this.rememberedRatingAt &&
          other.repeatDecision == this.repeatDecision &&
          other.repeatNotes == this.repeatNotes);
}

class ExperiencesCompanion extends UpdateCompanion<Experience> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> startDate;
  final Value<String?> endDate;
  final Value<String> status;
  final Value<String> checkinFrequency;
  final Value<DateTime?> finishedAt;
  final Value<int> rememberAfterDays;
  final Value<int?> rememberedRating;
  final Value<DateTime?> rememberedRatingAt;
  final Value<String?> repeatDecision;
  final Value<String?> repeatNotes;
  const ExperiencesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.checkinFrequency = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.rememberAfterDays = const Value.absent(),
    this.rememberedRating = const Value.absent(),
    this.rememberedRatingAt = const Value.absent(),
    this.repeatDecision = const Value.absent(),
    this.repeatNotes = const Value.absent(),
  });
  ExperiencesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required String startDate,
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.checkinFrequency = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.rememberAfterDays = const Value.absent(),
    this.rememberedRating = const Value.absent(),
    this.rememberedRatingAt = const Value.absent(),
    this.repeatDecision = const Value.absent(),
    this.repeatNotes = const Value.absent(),
  }) : name = Value(name),
       startDate = Value(startDate);
  static Insertable<Experience> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<String>? checkinFrequency,
    Expression<DateTime>? finishedAt,
    Expression<int>? rememberAfterDays,
    Expression<int>? rememberedRating,
    Expression<DateTime>? rememberedRatingAt,
    Expression<String>? repeatDecision,
    Expression<String>? repeatNotes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (checkinFrequency != null) 'checkin_frequency': checkinFrequency,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (rememberAfterDays != null) 'remember_after_days': rememberAfterDays,
      if (rememberedRating != null) 'remembered_rating': rememberedRating,
      if (rememberedRatingAt != null)
        'remembered_rating_at': rememberedRatingAt,
      if (repeatDecision != null) 'repeat_decision': repeatDecision,
      if (repeatNotes != null) 'repeat_notes': repeatNotes,
    });
  }

  ExperiencesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? startDate,
    Value<String?>? endDate,
    Value<String>? status,
    Value<String>? checkinFrequency,
    Value<DateTime?>? finishedAt,
    Value<int>? rememberAfterDays,
    Value<int?>? rememberedRating,
    Value<DateTime?>? rememberedRatingAt,
    Value<String?>? repeatDecision,
    Value<String?>? repeatNotes,
  }) {
    return ExperiencesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      checkinFrequency: checkinFrequency ?? this.checkinFrequency,
      finishedAt: finishedAt ?? this.finishedAt,
      rememberAfterDays: rememberAfterDays ?? this.rememberAfterDays,
      rememberedRating: rememberedRating ?? this.rememberedRating,
      rememberedRatingAt: rememberedRatingAt ?? this.rememberedRatingAt,
      repeatDecision: repeatDecision ?? this.repeatDecision,
      repeatNotes: repeatNotes ?? this.repeatNotes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (checkinFrequency.present) {
      map['checkin_frequency'] = Variable<String>(checkinFrequency.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (rememberAfterDays.present) {
      map['remember_after_days'] = Variable<int>(rememberAfterDays.value);
    }
    if (rememberedRating.present) {
      map['remembered_rating'] = Variable<int>(rememberedRating.value);
    }
    if (rememberedRatingAt.present) {
      map['remembered_rating_at'] = Variable<DateTime>(
        rememberedRatingAt.value,
      );
    }
    if (repeatDecision.present) {
      map['repeat_decision'] = Variable<String>(repeatDecision.value);
    }
    if (repeatNotes.present) {
      map['repeat_notes'] = Variable<String>(repeatNotes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperiencesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('checkinFrequency: $checkinFrequency, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('rememberAfterDays: $rememberAfterDays, ')
          ..write('rememberedRating: $rememberedRating, ')
          ..write('rememberedRatingAt: $rememberedRatingAt, ')
          ..write('repeatDecision: $repeatDecision, ')
          ..write('repeatNotes: $repeatNotes')
          ..write(')'))
        .toString();
  }
}

class $ExperienceParticipantsTable extends ExperienceParticipants
    with TableInfo<$ExperienceParticipantsTable, ExperienceParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperienceParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _experienceIdMeta = const VerificationMeta(
    'experienceId',
  );
  @override
  late final GeneratedColumn<int> experienceId = GeneratedColumn<int>(
    'experience_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    experienceId,
    displayName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experience_participants';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExperienceParticipant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('experience_id')) {
      context.handle(
        _experienceIdMeta,
        experienceId.isAcceptableOrUnknown(
          data['experience_id']!,
          _experienceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExperienceParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExperienceParticipant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      experienceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
    );
  }

  @override
  $ExperienceParticipantsTable createAlias(String alias) {
    return $ExperienceParticipantsTable(attachedDatabase, alias);
  }
}

class ExperienceParticipant extends DataClass
    implements Insertable<ExperienceParticipant> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int experienceId;
  final String displayName;
  const ExperienceParticipant({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.experienceId,
    required this.displayName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['experience_id'] = Variable<int>(experienceId);
    map['display_name'] = Variable<String>(displayName);
    return map;
  }

  ExperienceParticipantsCompanion toCompanion(bool nullToAbsent) {
    return ExperienceParticipantsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      experienceId: Value(experienceId),
      displayName: Value(displayName),
    );
  }

  factory ExperienceParticipant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExperienceParticipant(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      experienceId: serializer.fromJson<int>(json['experienceId']),
      displayName: serializer.fromJson<String>(json['displayName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'experienceId': serializer.toJson<int>(experienceId),
      'displayName': serializer.toJson<String>(displayName),
    };
  }

  ExperienceParticipant copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experienceId,
    String? displayName,
  }) => ExperienceParticipant(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    experienceId: experienceId ?? this.experienceId,
    displayName: displayName ?? this.displayName,
  );
  ExperienceParticipant copyWithCompanion(
    ExperienceParticipantsCompanion data,
  ) {
    return ExperienceParticipant(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      experienceId: data.experienceId.present
          ? data.experienceId.value
          : this.experienceId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExperienceParticipant(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('experienceId: $experienceId, ')
          ..write('displayName: $displayName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, experienceId, displayName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExperienceParticipant &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.experienceId == this.experienceId &&
          other.displayName == this.displayName);
}

class ExperienceParticipantsCompanion
    extends UpdateCompanion<ExperienceParticipant> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> experienceId;
  final Value<String> displayName;
  const ExperienceParticipantsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.experienceId = const Value.absent(),
    this.displayName = const Value.absent(),
  });
  ExperienceParticipantsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int experienceId,
    required String displayName,
  }) : experienceId = Value(experienceId),
       displayName = Value(displayName);
  static Insertable<ExperienceParticipant> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? experienceId,
    Expression<String>? displayName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (experienceId != null) 'experience_id': experienceId,
      if (displayName != null) 'display_name': displayName,
    });
  }

  ExperienceParticipantsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? experienceId,
    Value<String>? displayName,
  }) {
    return ExperienceParticipantsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      experienceId: experienceId ?? this.experienceId,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (experienceId.present) {
      map['experience_id'] = Variable<int>(experienceId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperienceParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('experienceId: $experienceId, ')
          ..write('displayName: $displayName')
          ..write(')'))
        .toString();
  }
}

class $CheckInsTable extends CheckIns with TableInfo<$CheckInsTable, CheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _experienceIdMeta = const VerificationMeta(
    'experienceId',
  );
  @override
  late final GeneratedColumn<int> experienceId = GeneratedColumn<int>(
    'experience_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participantIdMeta = const VerificationMeta(
    'participantId',
  );
  @override
  late final GeneratedColumn<int> participantId = GeneratedColumn<int>(
    'participant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markerMeta = const VerificationMeta('marker');
  @override
  late final GeneratedColumn<String> marker = GeneratedColumn<String>(
    'marker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _checkedAtMeta = const VerificationMeta(
    'checkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> checkedAt = GeneratedColumn<DateTime>(
    'checked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    experienceId,
    participantId,
    rating,
    note,
    marker,
    checkedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('experience_id')) {
      context.handle(
        _experienceIdMeta,
        experienceId.isAcceptableOrUnknown(
          data['experience_id']!,
          _experienceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceIdMeta);
    }
    if (data.containsKey('participant_id')) {
      context.handle(
        _participantIdMeta,
        participantId.isAcceptableOrUnknown(
          data['participant_id']!,
          _participantIdMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('marker')) {
      context.handle(
        _markerMeta,
        marker.isAcceptableOrUnknown(data['marker']!, _markerMeta),
      );
    }
    if (data.containsKey('checked_at')) {
      context.handle(
        _checkedAtMeta,
        checkedAt.isAcceptableOrUnknown(data['checked_at']!, _checkedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_checkedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckIn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      experienceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_id'],
      )!,
      participantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant_id'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      marker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marker'],
      )!,
      checkedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}checked_at'],
      )!,
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }
}

class CheckIn extends DataClass implements Insertable<CheckIn> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int experienceId;

  /// Null means the main user.
  final int? participantId;
  final int rating;
  final String? note;

  /// 'none', 'high' or 'low'.
  final String marker;

  /// When the check-in applies to. Editable, unlike createdAt.
  final DateTime checkedAt;
  const CheckIn({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.experienceId,
    this.participantId,
    required this.rating,
    this.note,
    required this.marker,
    required this.checkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['experience_id'] = Variable<int>(experienceId);
    if (!nullToAbsent || participantId != null) {
      map['participant_id'] = Variable<int>(participantId);
    }
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['marker'] = Variable<String>(marker);
    map['checked_at'] = Variable<DateTime>(checkedAt);
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      experienceId: Value(experienceId),
      participantId: participantId == null && nullToAbsent
          ? const Value.absent()
          : Value(participantId),
      rating: Value(rating),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      marker: Value(marker),
      checkedAt: Value(checkedAt),
    );
  }

  factory CheckIn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckIn(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      experienceId: serializer.fromJson<int>(json['experienceId']),
      participantId: serializer.fromJson<int?>(json['participantId']),
      rating: serializer.fromJson<int>(json['rating']),
      note: serializer.fromJson<String?>(json['note']),
      marker: serializer.fromJson<String>(json['marker']),
      checkedAt: serializer.fromJson<DateTime>(json['checkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'experienceId': serializer.toJson<int>(experienceId),
      'participantId': serializer.toJson<int?>(participantId),
      'rating': serializer.toJson<int>(rating),
      'note': serializer.toJson<String?>(note),
      'marker': serializer.toJson<String>(marker),
      'checkedAt': serializer.toJson<DateTime>(checkedAt),
    };
  }

  CheckIn copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experienceId,
    Value<int?> participantId = const Value.absent(),
    int? rating,
    Value<String?> note = const Value.absent(),
    String? marker,
    DateTime? checkedAt,
  }) => CheckIn(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    experienceId: experienceId ?? this.experienceId,
    participantId: participantId.present
        ? participantId.value
        : this.participantId,
    rating: rating ?? this.rating,
    note: note.present ? note.value : this.note,
    marker: marker ?? this.marker,
    checkedAt: checkedAt ?? this.checkedAt,
  );
  CheckIn copyWithCompanion(CheckInsCompanion data) {
    return CheckIn(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      experienceId: data.experienceId.present
          ? data.experienceId.value
          : this.experienceId,
      participantId: data.participantId.present
          ? data.participantId.value
          : this.participantId,
      rating: data.rating.present ? data.rating.value : this.rating,
      note: data.note.present ? data.note.value : this.note,
      marker: data.marker.present ? data.marker.value : this.marker,
      checkedAt: data.checkedAt.present ? data.checkedAt.value : this.checkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckIn(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('experienceId: $experienceId, ')
          ..write('participantId: $participantId, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('marker: $marker, ')
          ..write('checkedAt: $checkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    experienceId,
    participantId,
    rating,
    note,
    marker,
    checkedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckIn &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.experienceId == this.experienceId &&
          other.participantId == this.participantId &&
          other.rating == this.rating &&
          other.note == this.note &&
          other.marker == this.marker &&
          other.checkedAt == this.checkedAt);
}

class CheckInsCompanion extends UpdateCompanion<CheckIn> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> experienceId;
  final Value<int?> participantId;
  final Value<int> rating;
  final Value<String?> note;
  final Value<String> marker;
  final Value<DateTime> checkedAt;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.experienceId = const Value.absent(),
    this.participantId = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.marker = const Value.absent(),
    this.checkedAt = const Value.absent(),
  });
  CheckInsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int experienceId,
    this.participantId = const Value.absent(),
    required int rating,
    this.note = const Value.absent(),
    this.marker = const Value.absent(),
    required DateTime checkedAt,
  }) : experienceId = Value(experienceId),
       rating = Value(rating),
       checkedAt = Value(checkedAt);
  static Insertable<CheckIn> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? experienceId,
    Expression<int>? participantId,
    Expression<int>? rating,
    Expression<String>? note,
    Expression<String>? marker,
    Expression<DateTime>? checkedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (experienceId != null) 'experience_id': experienceId,
      if (participantId != null) 'participant_id': participantId,
      if (rating != null) 'rating': rating,
      if (note != null) 'note': note,
      if (marker != null) 'marker': marker,
      if (checkedAt != null) 'checked_at': checkedAt,
    });
  }

  CheckInsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? experienceId,
    Value<int?>? participantId,
    Value<int>? rating,
    Value<String?>? note,
    Value<String>? marker,
    Value<DateTime>? checkedAt,
  }) {
    return CheckInsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      experienceId: experienceId ?? this.experienceId,
      participantId: participantId ?? this.participantId,
      rating: rating ?? this.rating,
      note: note ?? this.note,
      marker: marker ?? this.marker,
      checkedAt: checkedAt ?? this.checkedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (experienceId.present) {
      map['experience_id'] = Variable<int>(experienceId.value);
    }
    if (participantId.present) {
      map['participant_id'] = Variable<int>(participantId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (marker.present) {
      map['marker'] = Variable<String>(marker.value);
    }
    if (checkedAt.present) {
      map['checked_at'] = Variable<DateTime>(checkedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('experienceId: $experienceId, ')
          ..write('participantId: $participantId, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('marker: $marker, ')
          ..write('checkedAt: $checkedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $PredictionsTable predictions = $PredictionsTable(this);
  late final $PredictionDateChangesTable predictionDateChanges =
      $PredictionDateChangesTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $JournalOptionsTable journalOptions = $JournalOptionsTable(this);
  late final $JournalReviewsTable journalReviews = $JournalReviewsTable(this);
  late final $DayPlansTable dayPlans = $DayPlansTable(this);
  late final $DayPlanTasksTable dayPlanTasks = $DayPlanTasksTable(this);
  late final $DayPlanDefaultsTable dayPlanDefaults = $DayPlanDefaultsTable(
    this,
  );
  late final $OpenLoopsTable openLoops = $OpenLoopsTable(this);
  late final $ShutdownsTable shutdowns = $ShutdownsTable(this);
  late final $WinddownStepsTable winddownSteps = $WinddownStepsTable(this);
  late final $WinddownRunsTable winddownRuns = $WinddownRunsTable(this);
  late final $ExperiencesTable experiences = $ExperiencesTable(this);
  late final $ExperienceParticipantsTable experienceParticipants =
      $ExperienceParticipantsTable(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tags,
    predictions,
    predictionDateChanges,
    journalEntries,
    journalOptions,
    journalReviews,
    dayPlans,
    dayPlanTasks,
    dayPlanDefaults,
    openLoops,
    shutdowns,
    winddownSteps,
    winddownRuns,
    experiences,
    experienceParticipants,
    checkIns,
  ];
}

typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String name,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> name,
});

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
          Tag,
          PrefetchHooks Function()
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
              }) => TagsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  BaseReferences<_$AppDatabase, $TagsTable, Tag>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
      Tag,
      PrefetchHooks Function()
    >;
typedef $$PredictionsTableCreateCompanionBuilder =
    PredictionsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String statement,
      required int confidence,
      required String resolveBy,
      Value<int?> tagId,
      Value<String?> outcome,
      Value<DateTime?> resolvedAt,
      Value<int?> journalEntryId,
    });
typedef $$PredictionsTableUpdateCompanionBuilder =
    PredictionsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> statement,
      Value<int> confidence,
      Value<String> resolveBy,
      Value<int?> tagId,
      Value<String?> outcome,
      Value<DateTime?> resolvedAt,
      Value<int?> journalEntryId,
    });

class $$PredictionsTableFilterComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statement => $composableBuilder(
    column: $table.statement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolveBy => $composableBuilder(
    column: $table.resolveBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PredictionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statement => $composableBuilder(
    column: $table.statement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolveBy => $composableBuilder(
    column: $table.resolveBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PredictionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get statement =>
      $composableBuilder(column: $table.statement, builder: (column) => column);

  GeneratedColumn<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resolveBy =>
      $composableBuilder(column: $table.resolveBy, builder: (column) => column);

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => column,
  );
}

class $$PredictionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictionsTable,
          Prediction,
          $$PredictionsTableFilterComposer,
          $$PredictionsTableOrderingComposer,
          $$PredictionsTableAnnotationComposer,
          $$PredictionsTableCreateCompanionBuilder,
          $$PredictionsTableUpdateCompanionBuilder,
          (
            Prediction,
            BaseReferences<_$AppDatabase, $PredictionsTable, Prediction>,
          ),
          Prediction,
          PrefetchHooks Function()
        > {
  $$PredictionsTableTableManager(_$AppDatabase db, $PredictionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredictionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PredictionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> statement = const Value.absent(),
                Value<int> confidence = const Value.absent(),
                Value<String> resolveBy = const Value.absent(),
                Value<int?> tagId = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int?> journalEntryId = const Value.absent(),
              }) => PredictionsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                statement: statement,
                confidence: confidence,
                resolveBy: resolveBy,
                tagId: tagId,
                outcome: outcome,
                resolvedAt: resolvedAt,
                journalEntryId: journalEntryId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String statement,
                required int confidence,
                required String resolveBy,
                Value<int?> tagId = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int?> journalEntryId = const Value.absent(),
              }) => PredictionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                statement: statement,
                confidence: confidence,
                resolveBy: resolveBy,
                tagId: tagId,
                outcome: outcome,
                resolvedAt: resolvedAt,
                journalEntryId: journalEntryId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PredictionsTable, Prediction>(table),
                  BaseReferences<_$AppDatabase, $PredictionsTable, Prediction>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PredictionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictionsTable,
      Prediction,
      $$PredictionsTableFilterComposer,
      $$PredictionsTableOrderingComposer,
      $$PredictionsTableAnnotationComposer,
      $$PredictionsTableCreateCompanionBuilder,
      $$PredictionsTableUpdateCompanionBuilder,
      (
        Prediction,
        BaseReferences<_$AppDatabase, $PredictionsTable, Prediction>,
      ),
      Prediction,
      PrefetchHooks Function()
    >;
typedef $$PredictionDateChangesTableCreateCompanionBuilder =
    PredictionDateChangesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int predictionId,
      required String oldDate,
      required String newDate,
    });
typedef $$PredictionDateChangesTableUpdateCompanionBuilder =
    PredictionDateChangesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> predictionId,
      Value<String> oldDate,
      Value<String> newDate,
    });

class $$PredictionDateChangesTableFilterComposer
    extends Composer<_$AppDatabase, $PredictionDateChangesTable> {
  $$PredictionDateChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldDate => $composableBuilder(
    column: $table.oldDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newDate => $composableBuilder(
    column: $table.newDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PredictionDateChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictionDateChangesTable> {
  $$PredictionDateChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldDate => $composableBuilder(
    column: $table.oldDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newDate => $composableBuilder(
    column: $table.newDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PredictionDateChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictionDateChangesTable> {
  $$PredictionDateChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get oldDate =>
      $composableBuilder(column: $table.oldDate, builder: (column) => column);

  GeneratedColumn<String> get newDate =>
      $composableBuilder(column: $table.newDate, builder: (column) => column);
}

class $$PredictionDateChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictionDateChangesTable,
          PredictionDateChange,
          $$PredictionDateChangesTableFilterComposer,
          $$PredictionDateChangesTableOrderingComposer,
          $$PredictionDateChangesTableAnnotationComposer,
          $$PredictionDateChangesTableCreateCompanionBuilder,
          $$PredictionDateChangesTableUpdateCompanionBuilder,
          (
            PredictionDateChange,
            BaseReferences<
              _$AppDatabase,
              $PredictionDateChangesTable,
              PredictionDateChange
            >,
          ),
          PredictionDateChange,
          PrefetchHooks Function()
        > {
  $$PredictionDateChangesTableTableManager(
    _$AppDatabase db,
    $PredictionDateChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictionDateChangesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PredictionDateChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PredictionDateChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> predictionId = const Value.absent(),
                Value<String> oldDate = const Value.absent(),
                Value<String> newDate = const Value.absent(),
              }) => PredictionDateChangesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                predictionId: predictionId,
                oldDate: oldDate,
                newDate: newDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int predictionId,
                required String oldDate,
                required String newDate,
              }) => PredictionDateChangesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                predictionId: predictionId,
                oldDate: oldDate,
                newDate: newDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $PredictionDateChangesTable,
                    PredictionDateChange
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PredictionDateChangesTable,
                    PredictionDateChange
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PredictionDateChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictionDateChangesTable,
      PredictionDateChange,
      $$PredictionDateChangesTableFilterComposer,
      $$PredictionDateChangesTableOrderingComposer,
      $$PredictionDateChangesTableAnnotationComposer,
      $$PredictionDateChangesTableCreateCompanionBuilder,
      $$PredictionDateChangesTableUpdateCompanionBuilder,
      (
        PredictionDateChange,
        BaseReferences<
          _$AppDatabase,
          $PredictionDateChangesTable,
          PredictionDateChange
        >,
      ),
      PredictionDateChange,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String decision,
      Value<String?> context,
      Value<int?> choiceOptionId,
      required String reasoning,
      required String expectedOutcome,
      required int confidence,
      Value<int?> tagId,
      required String reviewDate,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> decision,
      Value<String?> context,
      Value<int?> choiceOptionId,
      Value<String> reasoning,
      Value<String> expectedOutcome,
      Value<int> confidence,
      Value<int?> tagId,
      Value<String> reviewDate,
    });

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get choiceOptionId => $composableBuilder(
    column: $table.choiceOptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasoning => $composableBuilder(
    column: $table.reasoning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get choiceOptionId => $composableBuilder(
    column: $table.choiceOptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasoning => $composableBuilder(
    column: $table.reasoning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<int> get choiceOptionId => $composableBuilder(
    column: $table.choiceOptionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reasoning =>
      $composableBuilder(column: $table.reasoning, builder: (column) => column);

  GeneratedColumn<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => column,
  );
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (
            JournalEntry,
            BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
          ),
          JournalEntry,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<String?> context = const Value.absent(),
                Value<int?> choiceOptionId = const Value.absent(),
                Value<String> reasoning = const Value.absent(),
                Value<String> expectedOutcome = const Value.absent(),
                Value<int> confidence = const Value.absent(),
                Value<int?> tagId = const Value.absent(),
                Value<String> reviewDate = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                decision: decision,
                context: context,
                choiceOptionId: choiceOptionId,
                reasoning: reasoning,
                expectedOutcome: expectedOutcome,
                confidence: confidence,
                tagId: tagId,
                reviewDate: reviewDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String decision,
                Value<String?> context = const Value.absent(),
                Value<int?> choiceOptionId = const Value.absent(),
                required String reasoning,
                required String expectedOutcome,
                required int confidence,
                Value<int?> tagId = const Value.absent(),
                required String reviewDate,
              }) => JournalEntriesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                decision: decision,
                context: context,
                choiceOptionId: choiceOptionId,
                reasoning: reasoning,
                expectedOutcome: expectedOutcome,
                confidence: confidence,
                tagId: tagId,
                reviewDate: reviewDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JournalEntriesTable, JournalEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $JournalEntriesTable,
                    JournalEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (
        JournalEntry,
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
      ),
      JournalEntry,
      PrefetchHooks Function()
    >;
typedef $$JournalOptionsTableCreateCompanionBuilder =
    JournalOptionsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int entryId,
      required String body,
      required int sortOrder,
    });
typedef $$JournalOptionsTableUpdateCompanionBuilder =
    JournalOptionsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> entryId,
      Value<String> body,
      Value<int> sortOrder,
    });

class $$JournalOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $JournalOptionsTable> {
  $$JournalOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalOptionsTable> {
  $$JournalOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalOptionsTable> {
  $$JournalOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get entryId =>
      $composableBuilder(column: $table.entryId, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$JournalOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalOptionsTable,
          JournalOption,
          $$JournalOptionsTableFilterComposer,
          $$JournalOptionsTableOrderingComposer,
          $$JournalOptionsTableAnnotationComposer,
          $$JournalOptionsTableCreateCompanionBuilder,
          $$JournalOptionsTableUpdateCompanionBuilder,
          (
            JournalOption,
            BaseReferences<_$AppDatabase, $JournalOptionsTable, JournalOption>,
          ),
          JournalOption,
          PrefetchHooks Function()
        > {
  $$JournalOptionsTableTableManager(
    _$AppDatabase db,
    $JournalOptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => JournalOptionsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                entryId: entryId,
                body: body,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int entryId,
                required String body,
                required int sortOrder,
              }) => JournalOptionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                entryId: entryId,
                body: body,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JournalOptionsTable, JournalOption>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $JournalOptionsTable,
                    JournalOption
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalOptionsTable,
      JournalOption,
      $$JournalOptionsTableFilterComposer,
      $$JournalOptionsTableOrderingComposer,
      $$JournalOptionsTableAnnotationComposer,
      $$JournalOptionsTableCreateCompanionBuilder,
      $$JournalOptionsTableUpdateCompanionBuilder,
      (
        JournalOption,
        BaseReferences<_$AppDatabase, $JournalOptionsTable, JournalOption>,
      ),
      JournalOption,
      PrefetchHooks Function()
    >;
typedef $$JournalReviewsTableCreateCompanionBuilder =
    JournalReviewsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int entryId,
      required String whatHappened,
      required int reasoningScore,
      Value<String?> lessons,
      required DateTime reviewedAt,
    });
typedef $$JournalReviewsTableUpdateCompanionBuilder =
    JournalReviewsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> entryId,
      Value<String> whatHappened,
      Value<int> reasoningScore,
      Value<String?> lessons,
      Value<DateTime> reviewedAt,
    });

class $$JournalReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $JournalReviewsTable> {
  $$JournalReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatHappened => $composableBuilder(
    column: $table.whatHappened,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reasoningScore => $composableBuilder(
    column: $table.reasoningScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalReviewsTable> {
  $$JournalReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatHappened => $composableBuilder(
    column: $table.whatHappened,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reasoningScore => $composableBuilder(
    column: $table.reasoningScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalReviewsTable> {
  $$JournalReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get entryId =>
      $composableBuilder(column: $table.entryId, builder: (column) => column);

  GeneratedColumn<String> get whatHappened => $composableBuilder(
    column: $table.whatHappened,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reasoningScore => $composableBuilder(
    column: $table.reasoningScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lessons =>
      $composableBuilder(column: $table.lessons, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );
}

class $$JournalReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalReviewsTable,
          JournalReview,
          $$JournalReviewsTableFilterComposer,
          $$JournalReviewsTableOrderingComposer,
          $$JournalReviewsTableAnnotationComposer,
          $$JournalReviewsTableCreateCompanionBuilder,
          $$JournalReviewsTableUpdateCompanionBuilder,
          (
            JournalReview,
            BaseReferences<_$AppDatabase, $JournalReviewsTable, JournalReview>,
          ),
          JournalReview,
          PrefetchHooks Function()
        > {
  $$JournalReviewsTableTableManager(
    _$AppDatabase db,
    $JournalReviewsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> whatHappened = const Value.absent(),
                Value<int> reasoningScore = const Value.absent(),
                Value<String?> lessons = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
              }) => JournalReviewsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                entryId: entryId,
                whatHappened: whatHappened,
                reasoningScore: reasoningScore,
                lessons: lessons,
                reviewedAt: reviewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int entryId,
                required String whatHappened,
                required int reasoningScore,
                Value<String?> lessons = const Value.absent(),
                required DateTime reviewedAt,
              }) => JournalReviewsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                entryId: entryId,
                whatHappened: whatHappened,
                reasoningScore: reasoningScore,
                lessons: lessons,
                reviewedAt: reviewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JournalReviewsTable, JournalReview>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $JournalReviewsTable,
                    JournalReview
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalReviewsTable,
      JournalReview,
      $$JournalReviewsTableFilterComposer,
      $$JournalReviewsTableOrderingComposer,
      $$JournalReviewsTableAnnotationComposer,
      $$JournalReviewsTableCreateCompanionBuilder,
      $$JournalReviewsTableUpdateCompanionBuilder,
      (
        JournalReview,
        BaseReferences<_$AppDatabase, $JournalReviewsTable, JournalReview>,
      ),
      JournalReview,
      PrefetchHooks Function()
    >;
typedef $$DayPlansTableCreateCompanionBuilder = DayPlansCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String date,
});
typedef $$DayPlansTableUpdateCompanionBuilder = DayPlansCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> date,
});

class $$DayPlansTableFilterComposer
    extends Composer<_$AppDatabase, $DayPlansTable> {
  $$DayPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $DayPlansTable> {
  $$DayPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayPlansTable> {
  $$DayPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$DayPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayPlansTable,
          DayPlan,
          $$DayPlansTableFilterComposer,
          $$DayPlansTableOrderingComposer,
          $$DayPlansTableAnnotationComposer,
          $$DayPlansTableCreateCompanionBuilder,
          $$DayPlansTableUpdateCompanionBuilder,
          (DayPlan, BaseReferences<_$AppDatabase, $DayPlansTable, DayPlan>),
          DayPlan,
          PrefetchHooks Function()
        > {
  $$DayPlansTableTableManager(_$AppDatabase db, $DayPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => DayPlansCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String date,
              }) => DayPlansCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayPlansTable, DayPlan>(table),
                  BaseReferences<_$AppDatabase, $DayPlansTable, DayPlan>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayPlansTable,
      DayPlan,
      $$DayPlansTableFilterComposer,
      $$DayPlansTableOrderingComposer,
      $$DayPlansTableAnnotationComposer,
      $$DayPlansTableCreateCompanionBuilder,
      $$DayPlansTableUpdateCompanionBuilder,
      (DayPlan, BaseReferences<_$AppDatabase, $DayPlansTable, DayPlan>),
      DayPlan,
      PrefetchHooks Function()
    >;
typedef $$DayPlanTasksTableCreateCompanionBuilder =
    DayPlanTasksCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int dayPlanId,
      required String body,
      Value<bool> done,
      required int sortOrder,
    });
typedef $$DayPlanTasksTableUpdateCompanionBuilder =
    DayPlanTasksCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> dayPlanId,
      Value<String> body,
      Value<bool> done,
      Value<int> sortOrder,
    });

class $$DayPlanTasksTableFilterComposer
    extends Composer<_$AppDatabase, $DayPlanTasksTable> {
  $$DayPlanTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayPlanId => $composableBuilder(
    column: $table.dayPlanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayPlanTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $DayPlanTasksTable> {
  $$DayPlanTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayPlanId => $composableBuilder(
    column: $table.dayPlanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayPlanTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayPlanTasksTable> {
  $$DayPlanTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get dayPlanId =>
      $composableBuilder(column: $table.dayPlanId, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$DayPlanTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayPlanTasksTable,
          DayPlanTask,
          $$DayPlanTasksTableFilterComposer,
          $$DayPlanTasksTableOrderingComposer,
          $$DayPlanTasksTableAnnotationComposer,
          $$DayPlanTasksTableCreateCompanionBuilder,
          $$DayPlanTasksTableUpdateCompanionBuilder,
          (
            DayPlanTask,
            BaseReferences<_$AppDatabase, $DayPlanTasksTable, DayPlanTask>,
          ),
          DayPlanTask,
          PrefetchHooks Function()
        > {
  $$DayPlanTasksTableTableManager(_$AppDatabase db, $DayPlanTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayPlanTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayPlanTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayPlanTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> dayPlanId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DayPlanTasksCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dayPlanId: dayPlanId,
                body: body,
                done: done,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int dayPlanId,
                required String body,
                Value<bool> done = const Value.absent(),
                required int sortOrder,
              }) => DayPlanTasksCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dayPlanId: dayPlanId,
                body: body,
                done: done,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayPlanTasksTable, DayPlanTask>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DayPlanTasksTable,
                    DayPlanTask
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayPlanTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayPlanTasksTable,
      DayPlanTask,
      $$DayPlanTasksTableFilterComposer,
      $$DayPlanTasksTableOrderingComposer,
      $$DayPlanTasksTableAnnotationComposer,
      $$DayPlanTasksTableCreateCompanionBuilder,
      $$DayPlanTasksTableUpdateCompanionBuilder,
      (
        DayPlanTask,
        BaseReferences<_$AppDatabase, $DayPlanTasksTable, DayPlanTask>,
      ),
      DayPlanTask,
      PrefetchHooks Function()
    >;
typedef $$DayPlanDefaultsTableCreateCompanionBuilder =
    DayPlanDefaultsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int dayPlanId,
      required String label,
      required String choice,
      required int sortOrder,
    });
typedef $$DayPlanDefaultsTableUpdateCompanionBuilder =
    DayPlanDefaultsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> dayPlanId,
      Value<String> label,
      Value<String> choice,
      Value<int> sortOrder,
    });

class $$DayPlanDefaultsTableFilterComposer
    extends Composer<_$AppDatabase, $DayPlanDefaultsTable> {
  $$DayPlanDefaultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayPlanId => $composableBuilder(
    column: $table.dayPlanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get choice => $composableBuilder(
    column: $table.choice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayPlanDefaultsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayPlanDefaultsTable> {
  $$DayPlanDefaultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayPlanId => $composableBuilder(
    column: $table.dayPlanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get choice => $composableBuilder(
    column: $table.choice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayPlanDefaultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayPlanDefaultsTable> {
  $$DayPlanDefaultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get dayPlanId =>
      $composableBuilder(column: $table.dayPlanId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get choice =>
      $composableBuilder(column: $table.choice, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$DayPlanDefaultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayPlanDefaultsTable,
          DayPlanDefault,
          $$DayPlanDefaultsTableFilterComposer,
          $$DayPlanDefaultsTableOrderingComposer,
          $$DayPlanDefaultsTableAnnotationComposer,
          $$DayPlanDefaultsTableCreateCompanionBuilder,
          $$DayPlanDefaultsTableUpdateCompanionBuilder,
          (
            DayPlanDefault,
            BaseReferences<
              _$AppDatabase,
              $DayPlanDefaultsTable,
              DayPlanDefault
            >,
          ),
          DayPlanDefault,
          PrefetchHooks Function()
        > {
  $$DayPlanDefaultsTableTableManager(
    _$AppDatabase db,
    $DayPlanDefaultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayPlanDefaultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayPlanDefaultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayPlanDefaultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> dayPlanId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> choice = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DayPlanDefaultsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dayPlanId: dayPlanId,
                label: label,
                choice: choice,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int dayPlanId,
                required String label,
                required String choice,
                required int sortOrder,
              }) => DayPlanDefaultsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dayPlanId: dayPlanId,
                label: label,
                choice: choice,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayPlanDefaultsTable, DayPlanDefault>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DayPlanDefaultsTable,
                    DayPlanDefault
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayPlanDefaultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayPlanDefaultsTable,
      DayPlanDefault,
      $$DayPlanDefaultsTableFilterComposer,
      $$DayPlanDefaultsTableOrderingComposer,
      $$DayPlanDefaultsTableAnnotationComposer,
      $$DayPlanDefaultsTableCreateCompanionBuilder,
      $$DayPlanDefaultsTableUpdateCompanionBuilder,
      (
        DayPlanDefault,
        BaseReferences<_$AppDatabase, $DayPlanDefaultsTable, DayPlanDefault>,
      ),
      DayPlanDefault,
      PrefetchHooks Function()
    >;
typedef $$OpenLoopsTableCreateCompanionBuilder = OpenLoopsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String body,
  required String openedOn,
  Value<String?> closedOn,
  Value<int?> sourceTaskId,
});
typedef $$OpenLoopsTableUpdateCompanionBuilder = OpenLoopsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> body,
  Value<String> openedOn,
  Value<String?> closedOn,
  Value<int?> sourceTaskId,
});

class $$OpenLoopsTableFilterComposer
    extends Composer<_$AppDatabase, $OpenLoopsTable> {
  $$OpenLoopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closedOn => $composableBuilder(
    column: $table.closedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceTaskId => $composableBuilder(
    column: $table.sourceTaskId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OpenLoopsTableOrderingComposer
    extends Composer<_$AppDatabase, $OpenLoopsTable> {
  $$OpenLoopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closedOn => $composableBuilder(
    column: $table.closedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceTaskId => $composableBuilder(
    column: $table.sourceTaskId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OpenLoopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OpenLoopsTable> {
  $$OpenLoopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get openedOn =>
      $composableBuilder(column: $table.openedOn, builder: (column) => column);

  GeneratedColumn<String> get closedOn =>
      $composableBuilder(column: $table.closedOn, builder: (column) => column);

  GeneratedColumn<int> get sourceTaskId => $composableBuilder(
    column: $table.sourceTaskId,
    builder: (column) => column,
  );
}

class $$OpenLoopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OpenLoopsTable,
          OpenLoop,
          $$OpenLoopsTableFilterComposer,
          $$OpenLoopsTableOrderingComposer,
          $$OpenLoopsTableAnnotationComposer,
          $$OpenLoopsTableCreateCompanionBuilder,
          $$OpenLoopsTableUpdateCompanionBuilder,
          (OpenLoop, BaseReferences<_$AppDatabase, $OpenLoopsTable, OpenLoop>),
          OpenLoop,
          PrefetchHooks Function()
        > {
  $$OpenLoopsTableTableManager(_$AppDatabase db, $OpenLoopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OpenLoopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OpenLoopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OpenLoopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> openedOn = const Value.absent(),
                Value<String?> closedOn = const Value.absent(),
                Value<int?> sourceTaskId = const Value.absent(),
              }) => OpenLoopsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                body: body,
                openedOn: openedOn,
                closedOn: closedOn,
                sourceTaskId: sourceTaskId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String body,
                required String openedOn,
                Value<String?> closedOn = const Value.absent(),
                Value<int?> sourceTaskId = const Value.absent(),
              }) => OpenLoopsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                body: body,
                openedOn: openedOn,
                closedOn: closedOn,
                sourceTaskId: sourceTaskId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OpenLoopsTable, OpenLoop>(table),
                  BaseReferences<_$AppDatabase, $OpenLoopsTable, OpenLoop>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OpenLoopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OpenLoopsTable,
      OpenLoop,
      $$OpenLoopsTableFilterComposer,
      $$OpenLoopsTableOrderingComposer,
      $$OpenLoopsTableAnnotationComposer,
      $$OpenLoopsTableCreateCompanionBuilder,
      $$OpenLoopsTableUpdateCompanionBuilder,
      (OpenLoop, BaseReferences<_$AppDatabase, $OpenLoopsTable, OpenLoop>),
      OpenLoop,
      PrefetchHooks Function()
    >;
typedef $$ShutdownsTableCreateCompanionBuilder = ShutdownsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String date,
  required String firstStep,
  Value<DateTime?> closedAt,
});
typedef $$ShutdownsTableUpdateCompanionBuilder = ShutdownsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> date,
  Value<String> firstStep,
  Value<DateTime?> closedAt,
});

class $$ShutdownsTableFilterComposer
    extends Composer<_$AppDatabase, $ShutdownsTable> {
  $$ShutdownsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstStep => $composableBuilder(
    column: $table.firstStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShutdownsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShutdownsTable> {
  $$ShutdownsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstStep => $composableBuilder(
    column: $table.firstStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShutdownsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShutdownsTable> {
  $$ShutdownsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get firstStep =>
      $composableBuilder(column: $table.firstStep, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);
}

class $$ShutdownsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShutdownsTable,
          Shutdown,
          $$ShutdownsTableFilterComposer,
          $$ShutdownsTableOrderingComposer,
          $$ShutdownsTableAnnotationComposer,
          $$ShutdownsTableCreateCompanionBuilder,
          $$ShutdownsTableUpdateCompanionBuilder,
          (Shutdown, BaseReferences<_$AppDatabase, $ShutdownsTable, Shutdown>),
          Shutdown,
          PrefetchHooks Function()
        > {
  $$ShutdownsTableTableManager(_$AppDatabase db, $ShutdownsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShutdownsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShutdownsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShutdownsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> firstStep = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
              }) => ShutdownsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                firstStep: firstStep,
                closedAt: closedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String date,
                required String firstStep,
                Value<DateTime?> closedAt = const Value.absent(),
              }) => ShutdownsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                firstStep: firstStep,
                closedAt: closedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShutdownsTable, Shutdown>(table),
                  BaseReferences<_$AppDatabase, $ShutdownsTable, Shutdown>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShutdownsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShutdownsTable,
      Shutdown,
      $$ShutdownsTableFilterComposer,
      $$ShutdownsTableOrderingComposer,
      $$ShutdownsTableAnnotationComposer,
      $$ShutdownsTableCreateCompanionBuilder,
      $$ShutdownsTableUpdateCompanionBuilder,
      (Shutdown, BaseReferences<_$AppDatabase, $ShutdownsTable, Shutdown>),
      Shutdown,
      PrefetchHooks Function()
    >;
typedef $$WinddownStepsTableCreateCompanionBuilder =
    WinddownStepsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      Value<int?> minutes,
      required int sortOrder,
    });
typedef $$WinddownStepsTableUpdateCompanionBuilder =
    WinddownStepsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<int?> minutes,
      Value<int> sortOrder,
    });

class $$WinddownStepsTableFilterComposer
    extends Composer<_$AppDatabase, $WinddownStepsTable> {
  $$WinddownStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WinddownStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $WinddownStepsTable> {
  $$WinddownStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WinddownStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WinddownStepsTable> {
  $$WinddownStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$WinddownStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WinddownStepsTable,
          WinddownStep,
          $$WinddownStepsTableFilterComposer,
          $$WinddownStepsTableOrderingComposer,
          $$WinddownStepsTableAnnotationComposer,
          $$WinddownStepsTableCreateCompanionBuilder,
          $$WinddownStepsTableUpdateCompanionBuilder,
          (
            WinddownStep,
            BaseReferences<_$AppDatabase, $WinddownStepsTable, WinddownStep>,
          ),
          WinddownStep,
          PrefetchHooks Function()
        > {
  $$WinddownStepsTableTableManager(_$AppDatabase db, $WinddownStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WinddownStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WinddownStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WinddownStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> minutes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => WinddownStepsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                minutes: minutes,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                Value<int?> minutes = const Value.absent(),
                required int sortOrder,
              }) => WinddownStepsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                minutes: minutes,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WinddownStepsTable, WinddownStep>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WinddownStepsTable,
                    WinddownStep
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WinddownStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WinddownStepsTable,
      WinddownStep,
      $$WinddownStepsTableFilterComposer,
      $$WinddownStepsTableOrderingComposer,
      $$WinddownStepsTableAnnotationComposer,
      $$WinddownStepsTableCreateCompanionBuilder,
      $$WinddownStepsTableUpdateCompanionBuilder,
      (
        WinddownStep,
        BaseReferences<_$AppDatabase, $WinddownStepsTable, WinddownStep>,
      ),
      WinddownStep,
      PrefetchHooks Function()
    >;
typedef $$WinddownRunsTableCreateCompanionBuilder =
    WinddownRunsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String date,
      required DateTime startedAt,
      required String completedStepNames,
    });
typedef $$WinddownRunsTableUpdateCompanionBuilder =
    WinddownRunsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> date,
      Value<DateTime> startedAt,
      Value<String> completedStepNames,
    });

class $$WinddownRunsTableFilterComposer
    extends Composer<_$AppDatabase, $WinddownRunsTable> {
  $$WinddownRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedStepNames => $composableBuilder(
    column: $table.completedStepNames,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WinddownRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $WinddownRunsTable> {
  $$WinddownRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedStepNames => $composableBuilder(
    column: $table.completedStepNames,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WinddownRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WinddownRunsTable> {
  $$WinddownRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get completedStepNames => $composableBuilder(
    column: $table.completedStepNames,
    builder: (column) => column,
  );
}

class $$WinddownRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WinddownRunsTable,
          WinddownRun,
          $$WinddownRunsTableFilterComposer,
          $$WinddownRunsTableOrderingComposer,
          $$WinddownRunsTableAnnotationComposer,
          $$WinddownRunsTableCreateCompanionBuilder,
          $$WinddownRunsTableUpdateCompanionBuilder,
          (
            WinddownRun,
            BaseReferences<_$AppDatabase, $WinddownRunsTable, WinddownRun>,
          ),
          WinddownRun,
          PrefetchHooks Function()
        > {
  $$WinddownRunsTableTableManager(_$AppDatabase db, $WinddownRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WinddownRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WinddownRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WinddownRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<String> completedStepNames = const Value.absent(),
              }) => WinddownRunsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                startedAt: startedAt,
                completedStepNames: completedStepNames,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String date,
                required DateTime startedAt,
                required String completedStepNames,
              }) => WinddownRunsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                startedAt: startedAt,
                completedStepNames: completedStepNames,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WinddownRunsTable, WinddownRun>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WinddownRunsTable,
                    WinddownRun
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WinddownRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WinddownRunsTable,
      WinddownRun,
      $$WinddownRunsTableFilterComposer,
      $$WinddownRunsTableOrderingComposer,
      $$WinddownRunsTableAnnotationComposer,
      $$WinddownRunsTableCreateCompanionBuilder,
      $$WinddownRunsTableUpdateCompanionBuilder,
      (
        WinddownRun,
        BaseReferences<_$AppDatabase, $WinddownRunsTable, WinddownRun>,
      ),
      WinddownRun,
      PrefetchHooks Function()
    >;
typedef $$ExperiencesTableCreateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required String startDate,
      Value<String?> endDate,
      Value<String> status,
      Value<String> checkinFrequency,
      Value<DateTime?> finishedAt,
      Value<int> rememberAfterDays,
      Value<int?> rememberedRating,
      Value<DateTime?> rememberedRatingAt,
      Value<String?> repeatDecision,
      Value<String?> repeatNotes,
    });
typedef $$ExperiencesTableUpdateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> startDate,
      Value<String?> endDate,
      Value<String> status,
      Value<String> checkinFrequency,
      Value<DateTime?> finishedAt,
      Value<int> rememberAfterDays,
      Value<int?> rememberedRating,
      Value<DateTime?> rememberedRatingAt,
      Value<String?> repeatDecision,
      Value<String?> repeatNotes,
    });

class $$ExperiencesTableFilterComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkinFrequency => $composableBuilder(
    column: $table.checkinFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rememberAfterDays => $composableBuilder(
    column: $table.rememberAfterDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rememberedRating => $composableBuilder(
    column: $table.rememberedRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get rememberedRatingAt => $composableBuilder(
    column: $table.rememberedRatingAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatDecision => $composableBuilder(
    column: $table.repeatDecision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatNotes => $composableBuilder(
    column: $table.repeatNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExperiencesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkinFrequency => $composableBuilder(
    column: $table.checkinFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rememberAfterDays => $composableBuilder(
    column: $table.rememberAfterDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rememberedRating => $composableBuilder(
    column: $table.rememberedRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get rememberedRatingAt => $composableBuilder(
    column: $table.rememberedRatingAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatDecision => $composableBuilder(
    column: $table.repeatDecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatNotes => $composableBuilder(
    column: $table.repeatNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExperiencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get checkinFrequency => $composableBuilder(
    column: $table.checkinFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rememberAfterDays => $composableBuilder(
    column: $table.rememberAfterDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rememberedRating => $composableBuilder(
    column: $table.rememberedRating,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get rememberedRatingAt => $composableBuilder(
    column: $table.rememberedRatingAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repeatDecision => $composableBuilder(
    column: $table.repeatDecision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repeatNotes => $composableBuilder(
    column: $table.repeatNotes,
    builder: (column) => column,
  );
}

class $$ExperiencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExperiencesTable,
          Experience,
          $$ExperiencesTableFilterComposer,
          $$ExperiencesTableOrderingComposer,
          $$ExperiencesTableAnnotationComposer,
          $$ExperiencesTableCreateCompanionBuilder,
          $$ExperiencesTableUpdateCompanionBuilder,
          (
            Experience,
            BaseReferences<_$AppDatabase, $ExperiencesTable, Experience>,
          ),
          Experience,
          PrefetchHooks Function()
        > {
  $$ExperiencesTableTableManager(_$AppDatabase db, $ExperiencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExperiencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExperiencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExperiencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> checkinFrequency = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rememberAfterDays = const Value.absent(),
                Value<int?> rememberedRating = const Value.absent(),
                Value<DateTime?> rememberedRatingAt = const Value.absent(),
                Value<String?> repeatDecision = const Value.absent(),
                Value<String?> repeatNotes = const Value.absent(),
              }) => ExperiencesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                startDate: startDate,
                endDate: endDate,
                status: status,
                checkinFrequency: checkinFrequency,
                finishedAt: finishedAt,
                rememberAfterDays: rememberAfterDays,
                rememberedRating: rememberedRating,
                rememberedRatingAt: rememberedRatingAt,
                repeatDecision: repeatDecision,
                repeatNotes: repeatNotes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required String startDate,
                Value<String?> endDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> checkinFrequency = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rememberAfterDays = const Value.absent(),
                Value<int?> rememberedRating = const Value.absent(),
                Value<DateTime?> rememberedRatingAt = const Value.absent(),
                Value<String?> repeatDecision = const Value.absent(),
                Value<String?> repeatNotes = const Value.absent(),
              }) => ExperiencesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                startDate: startDate,
                endDate: endDate,
                status: status,
                checkinFrequency: checkinFrequency,
                finishedAt: finishedAt,
                rememberAfterDays: rememberAfterDays,
                rememberedRating: rememberedRating,
                rememberedRatingAt: rememberedRatingAt,
                repeatDecision: repeatDecision,
                repeatNotes: repeatNotes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExperiencesTable, Experience>(table),
                  BaseReferences<_$AppDatabase, $ExperiencesTable, Experience>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExperiencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExperiencesTable,
      Experience,
      $$ExperiencesTableFilterComposer,
      $$ExperiencesTableOrderingComposer,
      $$ExperiencesTableAnnotationComposer,
      $$ExperiencesTableCreateCompanionBuilder,
      $$ExperiencesTableUpdateCompanionBuilder,
      (
        Experience,
        BaseReferences<_$AppDatabase, $ExperiencesTable, Experience>,
      ),
      Experience,
      PrefetchHooks Function()
    >;
typedef $$ExperienceParticipantsTableCreateCompanionBuilder =
    ExperienceParticipantsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int experienceId,
      required String displayName,
    });
typedef $$ExperienceParticipantsTableUpdateCompanionBuilder =
    ExperienceParticipantsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> experienceId,
      Value<String> displayName,
    });

class $$ExperienceParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $ExperienceParticipantsTable> {
  $$ExperienceParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExperienceParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperienceParticipantsTable> {
  $$ExperienceParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExperienceParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperienceParticipantsTable> {
  $$ExperienceParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );
}

class $$ExperienceParticipantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExperienceParticipantsTable,
          ExperienceParticipant,
          $$ExperienceParticipantsTableFilterComposer,
          $$ExperienceParticipantsTableOrderingComposer,
          $$ExperienceParticipantsTableAnnotationComposer,
          $$ExperienceParticipantsTableCreateCompanionBuilder,
          $$ExperienceParticipantsTableUpdateCompanionBuilder,
          (
            ExperienceParticipant,
            BaseReferences<
              _$AppDatabase,
              $ExperienceParticipantsTable,
              ExperienceParticipant
            >,
          ),
          ExperienceParticipant,
          PrefetchHooks Function()
        > {
  $$ExperienceParticipantsTableTableManager(
    _$AppDatabase db,
    $ExperienceParticipantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExperienceParticipantsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ExperienceParticipantsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExperienceParticipantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> experienceId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
              }) => ExperienceParticipantsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                experienceId: experienceId,
                displayName: displayName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int experienceId,
                required String displayName,
              }) => ExperienceParticipantsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                experienceId: experienceId,
                displayName: displayName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ExperienceParticipantsTable,
                    ExperienceParticipant
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExperienceParticipantsTable,
                    ExperienceParticipant
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExperienceParticipantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExperienceParticipantsTable,
      ExperienceParticipant,
      $$ExperienceParticipantsTableFilterComposer,
      $$ExperienceParticipantsTableOrderingComposer,
      $$ExperienceParticipantsTableAnnotationComposer,
      $$ExperienceParticipantsTableCreateCompanionBuilder,
      $$ExperienceParticipantsTableUpdateCompanionBuilder,
      (
        ExperienceParticipant,
        BaseReferences<
          _$AppDatabase,
          $ExperienceParticipantsTable,
          ExperienceParticipant
        >,
      ),
      ExperienceParticipant,
      PrefetchHooks Function()
    >;
typedef $$CheckInsTableCreateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required int experienceId,
  Value<int?> participantId,
  required int rating,
  Value<String?> note,
  Value<String> marker,
  required DateTime checkedAt,
});
typedef $$CheckInsTableUpdateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> experienceId,
  Value<int?> participantId,
  Value<int> rating,
  Value<String?> note,
  Value<String> marker,
  Value<DateTime> checkedAt,
});

class $$CheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get participantId => $composableBuilder(
    column: $table.participantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkedAt => $composableBuilder(
    column: $table.checkedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get participantId => $composableBuilder(
    column: $table.participantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkedAt => $composableBuilder(
    column: $table.checkedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get experienceId => $composableBuilder(
    column: $table.experienceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get participantId => $composableBuilder(
    column: $table.participantId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get marker =>
      $composableBuilder(column: $table.marker, builder: (column) => column);

  GeneratedColumn<DateTime> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => column);
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInsTable,
          CheckIn,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (CheckIn, BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn>),
          CheckIn,
          PrefetchHooks Function()
        > {
  $$CheckInsTableTableManager(_$AppDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> experienceId = const Value.absent(),
                Value<int?> participantId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> marker = const Value.absent(),
                Value<DateTime> checkedAt = const Value.absent(),
              }) => CheckInsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                experienceId: experienceId,
                participantId: participantId,
                rating: rating,
                note: note,
                marker: marker,
                checkedAt: checkedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int experienceId,
                Value<int?> participantId = const Value.absent(),
                required int rating,
                Value<String?> note = const Value.absent(),
                Value<String> marker = const Value.absent(),
                required DateTime checkedAt,
              }) => CheckInsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                experienceId: experienceId,
                participantId: participantId,
                rating: rating,
                note: note,
                marker: marker,
                checkedAt: checkedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CheckInsTable, CheckIn>(table),
                  BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInsTable,
      CheckIn,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (CheckIn, BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn>),
      CheckIn,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$PredictionsTableTableManager get predictions =>
      $$PredictionsTableTableManager(_db, _db.predictions);
  $$PredictionDateChangesTableTableManager get predictionDateChanges =>
      $$PredictionDateChangesTableTableManager(_db, _db.predictionDateChanges);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$JournalOptionsTableTableManager get journalOptions =>
      $$JournalOptionsTableTableManager(_db, _db.journalOptions);
  $$JournalReviewsTableTableManager get journalReviews =>
      $$JournalReviewsTableTableManager(_db, _db.journalReviews);
  $$DayPlansTableTableManager get dayPlans =>
      $$DayPlansTableTableManager(_db, _db.dayPlans);
  $$DayPlanTasksTableTableManager get dayPlanTasks =>
      $$DayPlanTasksTableTableManager(_db, _db.dayPlanTasks);
  $$DayPlanDefaultsTableTableManager get dayPlanDefaults =>
      $$DayPlanDefaultsTableTableManager(_db, _db.dayPlanDefaults);
  $$OpenLoopsTableTableManager get openLoops =>
      $$OpenLoopsTableTableManager(_db, _db.openLoops);
  $$ShutdownsTableTableManager get shutdowns =>
      $$ShutdownsTableTableManager(_db, _db.shutdowns);
  $$WinddownStepsTableTableManager get winddownSteps =>
      $$WinddownStepsTableTableManager(_db, _db.winddownSteps);
  $$WinddownRunsTableTableManager get winddownRuns =>
      $$WinddownRunsTableTableManager(_db, _db.winddownRuns);
  $$ExperiencesTableTableManager get experiences =>
      $$ExperiencesTableTableManager(_db, _db.experiences);
  $$ExperienceParticipantsTableTableManager get experienceParticipants =>
      $$ExperienceParticipantsTableTableManager(
        _db,
        _db.experienceParticipants,
      );
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
}
