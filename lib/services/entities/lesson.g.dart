// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetLessonCollection on Isar {
  IsarCollection<Lesson> get lessons => this.collection();
}

const LessonSchema = CollectionSchema(
  name: r'Lesson',
  id: 6343151657775798464,
  properties: {
    r'day': PropertySchema(
      id: 0,
      name: r'day',
      type: IsarType.string,
    ),
    r'fromTime': PropertySchema(
      id: 1,
      name: r'fromTime',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'toTime': PropertySchema(
      id: 3,
      name: r'toTime',
      type: IsarType.long,
    )
  },
  estimateSize: _lessonEstimateSize,
  serialize: _lessonSerialize,
  deserialize: _lessonDeserialize,
  deserializeProp: _lessonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'grades': LinkSchema(
      id: 6692395525704602047,
      name: r'grades',
      target: r'Grade',
      single: false,
    ),
    r'students': LinkSchema(
      id: 6818576063106229161,
      name: r'students',
      target: r'Student',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _lessonGetId,
  getLinks: _lessonGetLinks,
  attach: _lessonAttach,
  version: '3.0.5',
);

int _lessonEstimateSize(
  Lesson object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.day;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _lessonSerialize(
  Lesson object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.day);
  writer.writeLong(offsets[1], object.fromTime);
  writer.writeString(offsets[2], object.name);
  writer.writeLong(offsets[3], object.toTime);
}

Lesson _lessonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lesson();
  object.day = reader.readStringOrNull(offsets[0]);
  object.fromTime = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[2]);
  object.toTime = reader.readLongOrNull(offsets[3]);
  return object;
}

P _lessonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lessonGetId(Lesson object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lessonGetLinks(Lesson object) {
  return [object.grades, object.students];
}

void _lessonAttach(IsarCollection<dynamic> col, Id id, Lesson object) {
  object.id = id;
  object.grades.attach(col, col.isar.collection<Grade>(), r'grades', id);
  object.students.attach(col, col.isar.collection<Student>(), r'students', id);
}

extension LessonQueryWhereSort on QueryBuilder<Lesson, Lesson, QWhere> {
  QueryBuilder<Lesson, Lesson, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LessonQueryWhere on QueryBuilder<Lesson, Lesson, QWhereClause> {
  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LessonQueryFilter on QueryBuilder<Lesson, Lesson, QFilterCondition> {
  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'day',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'day',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'day',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> dayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'day',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromTime',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromTime',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> fromTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toTime',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toTime',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> toTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LessonQueryObject on QueryBuilder<Lesson, Lesson, QFilterCondition> {}

extension LessonQueryLinks on QueryBuilder<Lesson, Lesson, QFilterCondition> {
  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> grades(
      FilterQuery<Grade> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'grades');
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grades', length, true, length, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grades', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grades', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grades', 0, true, length, include);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grades', length, include, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> gradesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'grades', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> students(
      FilterQuery<Student> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'students');
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', length, true, length, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, true, length, include);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', length, include, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> studentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'students', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LessonQuerySortBy on QueryBuilder<Lesson, Lesson, QSortBy> {
  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByFromTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromTime', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByFromTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromTime', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByToTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toTime', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByToTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toTime', Sort.desc);
    });
  }
}

extension LessonQuerySortThenBy on QueryBuilder<Lesson, Lesson, QSortThenBy> {
  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByFromTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromTime', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByFromTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromTime', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByToTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toTime', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByToTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toTime', Sort.desc);
    });
  }
}

extension LessonQueryWhereDistinct on QueryBuilder<Lesson, Lesson, QDistinct> {
  QueryBuilder<Lesson, Lesson, QDistinct> distinctByDay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByFromTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromTime');
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByToTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toTime');
    });
  }
}

extension LessonQueryProperty on QueryBuilder<Lesson, Lesson, QQueryProperty> {
  QueryBuilder<Lesson, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Lesson, String?, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<Lesson, int?, QQueryOperations> fromTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromTime');
    });
  }

  QueryBuilder<Lesson, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Lesson, int?, QQueryOperations> toTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toTime');
    });
  }
}
