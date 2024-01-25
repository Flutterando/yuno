// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlatformDataCollection on Isar {
  IsarCollection<PlatformData> get platformDatas => this.collection();
}

const PlatformDataSchema = CollectionSchema(
  name: r'PlatformData',
  id: 6752674838221417775,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'folder': PropertySchema(
      id: 1,
      name: r'folder',
      type: IsarType.string,
    ),
    r'folderCover': PropertySchema(
      id: 2,
      name: r'folderCover',
      type: IsarType.string,
    ),
    r'games': PropertySchema(
      id: 3,
      name: r'games',
      type: IsarType.objectList,
      target: r'GameData',
    ),
    r'lastUpdate': PropertySchema(
      id: 4,
      name: r'lastUpdate',
      type: IsarType.dateTime,
    ),
    r'playerExtra': PropertySchema(
      id: 5,
      name: r'playerExtra',
      type: IsarType.string,
    ),
    r'playerPackageId': PropertySchema(
      id: 6,
      name: r'playerPackageId',
      type: IsarType.string,
    )
  },
  estimateSize: _platformDataEstimateSize,
  serialize: _platformDataSerialize,
  deserialize: _platformDataDeserialize,
  deserializeProp: _platformDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'GameData': GameDataSchema},
  getId: _platformDataGetId,
  getLinks: _platformDataGetLinks,
  attach: _platformDataAttach,
  version: '3.1.0+1',
);

int _platformDataEstimateSize(
  PlatformData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.folder.length * 3;
  {
    final value = object.folderCover;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.games.length * 3;
  {
    final offsets = allOffsets[GameData]!;
    for (var i = 0; i < object.games.length; i++) {
      final value = object.games[i];
      bytesCount += GameDataSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.playerExtra;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.playerPackageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _platformDataSerialize(
  PlatformData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.folder);
  writer.writeString(offsets[2], object.folderCover);
  writer.writeObjectList<GameData>(
    offsets[3],
    allOffsets,
    GameDataSchema.serialize,
    object.games,
  );
  writer.writeDateTime(offsets[4], object.lastUpdate);
  writer.writeString(offsets[5], object.playerExtra);
  writer.writeString(offsets[6], object.playerPackageId);
}

PlatformData _platformDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlatformData();
  object.category = reader.readString(offsets[0]);
  object.folder = reader.readString(offsets[1]);
  object.folderCover = reader.readStringOrNull(offsets[2]);
  object.games = reader.readObjectList<GameData>(
        offsets[3],
        GameDataSchema.deserialize,
        allOffsets,
        GameData(),
      ) ??
      [];
  object.id = id;
  object.lastUpdate = reader.readDateTime(offsets[4]);
  object.playerExtra = reader.readStringOrNull(offsets[5]);
  object.playerPackageId = reader.readStringOrNull(offsets[6]);
  return object;
}

P _platformDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectList<GameData>(
            offset,
            GameDataSchema.deserialize,
            allOffsets,
            GameData(),
          ) ??
          []) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _platformDataGetId(PlatformData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _platformDataGetLinks(PlatformData object) {
  return [];
}

void _platformDataAttach(
    IsarCollection<dynamic> col, Id id, PlatformData object) {
  object.id = id;
}

extension PlatformDataQueryWhereSort
    on QueryBuilder<PlatformData, PlatformData, QWhere> {
  QueryBuilder<PlatformData, PlatformData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlatformDataQueryWhere
    on QueryBuilder<PlatformData, PlatformData, QWhereClause> {
  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idBetween(
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

extension PlatformDataQueryFilter
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {
  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> folderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> folderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> folderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folder',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folder',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folder',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'folderCover',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'folderCover',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folderCover',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderCover',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderCover',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      folderCoverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderCover',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      gamesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'games',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      lastUpdateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      lastUpdateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      lastUpdateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      lastUpdateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playerExtra',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playerExtra',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerExtra',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerExtra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerExtra',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerExtra',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerExtraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerExtra',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playerPackageId',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playerPackageId',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerPackageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerPackageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      playerPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerPackageId',
        value: '',
      ));
    });
  }
}

extension PlatformDataQueryObject
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {
  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> gamesElement(
      FilterQuery<GameData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'games');
    });
  }
}

extension PlatformDataQueryLinks
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {}

extension PlatformDataQuerySortBy
    on QueryBuilder<PlatformData, PlatformData, QSortBy> {
  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByFolder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folder', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByFolderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folder', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByFolderCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderCover', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByFolderCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderCover', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByPlayerExtra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerExtra', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByPlayerExtraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerExtra', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByPlayerPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerPackageId', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByPlayerPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerPackageId', Sort.desc);
    });
  }
}

extension PlatformDataQuerySortThenBy
    on QueryBuilder<PlatformData, PlatformData, QSortThenBy> {
  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByFolder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folder', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByFolderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folder', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByFolderCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderCover', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByFolderCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderCover', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByPlayerExtra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerExtra', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByPlayerExtraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerExtra', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByPlayerPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerPackageId', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByPlayerPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerPackageId', Sort.desc);
    });
  }
}

extension PlatformDataQueryWhereDistinct
    on QueryBuilder<PlatformData, PlatformData, QDistinct> {
  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByFolder(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folder', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByFolderCover(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderCover', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByPlayerExtra(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerExtra', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByPlayerPackageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerPackageId',
          caseSensitive: caseSensitive);
    });
  }
}

extension PlatformDataQueryProperty
    on QueryBuilder<PlatformData, PlatformData, QQueryProperty> {
  QueryBuilder<PlatformData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlatformData, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<PlatformData, String, QQueryOperations> folderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folder');
    });
  }

  QueryBuilder<PlatformData, String?, QQueryOperations> folderCoverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderCover');
    });
  }

  QueryBuilder<PlatformData, List<GameData>, QQueryOperations> gamesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'games');
    });
  }

  QueryBuilder<PlatformData, DateTime, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<PlatformData, String?, QQueryOperations> playerExtraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerExtra');
    });
  }

  QueryBuilder<PlatformData, String?, QQueryOperations>
      playerPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerPackageId');
    });
  }
}
