// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entities.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7404915061601985081),
      name: 'Chapter',
      lastPropertyId: const IdUid(9, 39795470768256308),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3861090007736717555),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3177957672925488017),
            name: 'chapterId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6664497570300867727),
            name: 'chapterOrderId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2365062685862021004),
            name: 'courseId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 588275325284121449),
            name: 'chapterDescrip',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6898161187639581085),
            name: 'chapterName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3557115757720761817),
            name: 'quesNum',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 314902130706333835),
            name: 'quesTime',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 39795470768256308),
            name: 'progress',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 9053878565315574588),
      name: 'FirebaseLocalNotification',
      lastPropertyId: const IdUid(6, 6916359913654828906),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1549482739562687613),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4120248776441120976),
            name: 'isLive',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3384067791660709696),
            name: 'dataTitle',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4500443888049963492),
            name: 'dataBody',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 486660275391700162),
            name: 'dataLink',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6916359913654828906),
            name: 'dataImageLink',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 739835613315059878),
      name: 'HighScore',
      lastPropertyId: const IdUid(4, 8013174645453365190),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7982191930201866416),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7473720940423056605),
            name: 'coursecode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8660581152956728995),
            name: 'chapterName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8013174645453365190),
            name: 'score',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 4438445763303632323),
      name: 'Question',
      lastPropertyId: const IdUid(10, 3354060474848758729),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9108074647425217572),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6939372603507816888),
            name: 'courseId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6498248217149435911),
            name: 'chapterId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4269700085437339139),
            name: 'question',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1473220820051302872),
            name: 'correctAnswer',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8639258681293365666),
            name: 'solution',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5460945727531095455),
            name: 'option2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2639053387414287933),
            name: 'option3',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 680360506538924923),
            name: 'option4',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3354060474848758729),
            name: 'isRead',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 6343919147638927820),
      name: 'RegCourse',
      lastPropertyId: const IdUid(10, 8092652691112594613),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1556050457851675922),
            name: 'courseId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 2211902723811375690),
            name: 'courseName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3280025535158152327),
            name: 'coursecode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4641003378697072288),
            name: 'courseDescrip',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7761860310472845269),
            name: 'expireAt',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1812802038240323545),
            name: 'courseImage',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8793788180722161255),
            name: 'progress',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 118412640805091654),
            name: 'courseChatLink',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 1921012200650775586),
            name: 'courseMaterialLink',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 8092652691112594613),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 4318158739013390804),
      name: 'Status',
      lastPropertyId: const IdUid(7, 7825401977685266985),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6377668073550595250),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4660836564111093394),
            name: 'url',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2547599162669546475),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1787178619768076628),
            name: 'time',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1758555201623151481),
            name: 'caption',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7823888228139177809),
            name: 'shown',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7825401977685266985),
            name: 'level',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(6, 4318158739013390804),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Chapter: EntityDefinition<Chapter>(
        model: _entities[0],
        toOneRelations: (Chapter object) => [],
        toManyRelations: (Chapter object) => {},
        getId: (Chapter object) => object.id,
        setId: (Chapter object, int id) {
          object.id = id;
        },
        objectToFB: (Chapter object, fb.Builder fbb) {
          final chapterDescripOffset = object.chapterDescrip == null
              ? null
              : fbb.writeString(object.chapterDescrip!);
          final chapterNameOffset = object.chapterName == null
              ? null
              : fbb.writeString(object.chapterName!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.chapterId);
          fbb.addInt64(2, object.chapterOrderId);
          fbb.addInt64(3, object.courseId);
          fbb.addOffset(4, chapterDescripOffset);
          fbb.addOffset(5, chapterNameOffset);
          fbb.addInt64(6, object.quesNum);
          fbb.addInt64(7, object.quesTime);
          fbb.addInt64(8, object.progress);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Chapter(
              chapterId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              courseId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              chapterName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              chapterOrderId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              chapterDescrip: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              quesNum: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              quesTime: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              progress: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));

          return object;
        }),
    FirebaseLocalNotification: EntityDefinition<FirebaseLocalNotification>(
        model: _entities[1],
        toOneRelations: (FirebaseLocalNotification object) => [],
        toManyRelations: (FirebaseLocalNotification object) => {},
        getId: (FirebaseLocalNotification object) => object.id,
        setId: (FirebaseLocalNotification object, int id) {
          object.id = id;
        },
        objectToFB: (FirebaseLocalNotification object, fb.Builder fbb) {
          final isLiveOffset =
              object.isLive == null ? null : fbb.writeString(object.isLive!);
          final dataTitleOffset = object.dataTitle == null
              ? null
              : fbb.writeString(object.dataTitle!);
          final dataBodyOffset = object.dataBody == null
              ? null
              : fbb.writeString(object.dataBody!);
          final dataLinkOffset = object.dataLink == null
              ? null
              : fbb.writeString(object.dataLink!);
          final dataImageLinkOffset = object.dataImageLink == null
              ? null
              : fbb.writeString(object.dataImageLink!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, isLiveOffset);
          fbb.addOffset(2, dataTitleOffset);
          fbb.addOffset(3, dataBodyOffset);
          fbb.addOffset(4, dataLinkOffset);
          fbb.addOffset(5, dataImageLinkOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FirebaseLocalNotification(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              isLive: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              dataTitle: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              dataBody: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              dataLink: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              dataImageLink: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14));

          return object;
        }),
    HighScore: EntityDefinition<HighScore>(
        model: _entities[2],
        toOneRelations: (HighScore object) => [],
        toManyRelations: (HighScore object) => {},
        getId: (HighScore object) => object.id,
        setId: (HighScore object, int id) {
          object.id = id;
        },
        objectToFB: (HighScore object, fb.Builder fbb) {
          final coursecodeOffset = object.coursecode == null
              ? null
              : fbb.writeString(object.coursecode!);
          final chapterNameOffset = object.chapterName == null
              ? null
              : fbb.writeString(object.chapterName!);
          final scoreOffset =
              object.score == null ? null : fbb.writeString(object.score!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, coursecodeOffset);
          fbb.addOffset(2, chapterNameOffset);
          fbb.addOffset(3, scoreOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = HighScore(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              coursecode: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              chapterName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              score: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10));

          return object;
        }),
    Question: EntityDefinition<Question>(
        model: _entities[3],
        toOneRelations: (Question object) => [],
        toManyRelations: (Question object) => {},
        getId: (Question object) => object.id,
        setId: (Question object, int id) {
          object.id = id;
        },
        objectToFB: (Question object, fb.Builder fbb) {
          final questionOffset = object.question == null
              ? null
              : fbb.writeString(object.question!);
          final correctAnswerOffset = object.correctAnswer == null
              ? null
              : fbb.writeString(object.correctAnswer!);
          final solutionOffset = object.solution == null
              ? null
              : fbb.writeString(object.solution!);
          final option2Offset =
              object.option2 == null ? null : fbb.writeString(object.option2!);
          final option3Offset =
              object.option3 == null ? null : fbb.writeString(object.option3!);
          final option4Offset =
              object.option4 == null ? null : fbb.writeString(object.option4!);
          final isReadOffset =
              object.isRead == null ? null : fbb.writeString(object.isRead!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.courseId);
          fbb.addInt64(2, object.chapterId);
          fbb.addOffset(3, questionOffset);
          fbb.addOffset(4, correctAnswerOffset);
          fbb.addOffset(5, solutionOffset);
          fbb.addOffset(6, option2Offset);
          fbb.addOffset(7, option3Offset);
          fbb.addOffset(8, option4Offset);
          fbb.addOffset(9, isReadOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Question(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              courseId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              chapterId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              question: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              correctAnswer: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              solution: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              option2: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              option3: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              option4: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20),
              isRead: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 22));

          return object;
        }),
    RegCourse: EntityDefinition<RegCourse>(
        model: _entities[4],
        toOneRelations: (RegCourse object) => [],
        toManyRelations: (RegCourse object) => {},
        getId: (RegCourse object) => object.id,
        setId: (RegCourse object, int id) {
          object.id = id;
        },
        objectToFB: (RegCourse object, fb.Builder fbb) {
          final courseNameOffset = object.courseName == null
              ? null
              : fbb.writeString(object.courseName!);
          final coursecodeOffset = object.coursecode == null
              ? null
              : fbb.writeString(object.coursecode!);
          final courseDescripOffset = object.courseDescrip == null
              ? null
              : fbb.writeString(object.courseDescrip!);
          final expireAtOffset = object.expireAt == null
              ? null
              : fbb.writeString(object.expireAt!);
          final courseImageOffset = object.courseImage == null
              ? null
              : fbb.writeString(object.courseImage!);
          final courseChatLinkOffset = object.courseChatLink == null
              ? null
              : fbb.writeString(object.courseChatLink!);
          final courseMaterialLinkOffset = object.courseMaterialLink == null
              ? null
              : fbb.writeString(object.courseMaterialLink!);
          fbb.startTable(11);
          fbb.addInt64(0, object.courseId);
          fbb.addOffset(1, courseNameOffset);
          fbb.addOffset(2, coursecodeOffset);
          fbb.addOffset(3, courseDescripOffset);
          fbb.addOffset(4, expireAtOffset);
          fbb.addOffset(5, courseImageOffset);
          fbb.addInt64(6, object.progress);
          fbb.addOffset(7, courseChatLinkOffset);
          fbb.addOffset(8, courseMaterialLinkOffset);
          fbb.addInt64(9, object.id ?? 0);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = RegCourse(
              courseId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              courseName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              coursecode: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              courseDescrip: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              expireAt: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              courseImage: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              progress: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              courseChatLink: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              courseMaterialLink: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 20),
              id: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22));

          return object;
        }),
    Status: EntityDefinition<Status>(
        model: _entities[5],
        toOneRelations: (Status object) => [],
        toManyRelations: (Status object) => {},
        getId: (Status object) => object.id,
        setId: (Status object, int id) {
          object.id = id;
        },
        objectToFB: (Status object, fb.Builder fbb) {
          final urlOffset = fbb.writeString(object.url);
          final typeOffset = fbb.writeString(object.type);
          final captionOffset =
              object.caption == null ? null : fbb.writeString(object.caption!);
          final shownOffset = fbb.writeString(object.shown);
          final levelOffset = fbb.writeString(object.level);
          fbb.startTable(8);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, urlOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addInt64(3, object.time.millisecondsSinceEpoch);
          fbb.addOffset(4, captionOffset);
          fbb.addOffset(5, shownOffset);
          fbb.addOffset(6, levelOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Status(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              url: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              time: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)),
              caption: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              shown: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              level: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Chapter] entity fields to define ObjectBox queries.
class Chapter_ {
  /// see [Chapter.id]
  static final id = QueryIntegerProperty<Chapter>(_entities[0].properties[0]);

  /// see [Chapter.chapterId]
  static final chapterId =
      QueryIntegerProperty<Chapter>(_entities[0].properties[1]);

  /// see [Chapter.chapterOrderId]
  static final chapterOrderId =
      QueryIntegerProperty<Chapter>(_entities[0].properties[2]);

  /// see [Chapter.courseId]
  static final courseId =
      QueryIntegerProperty<Chapter>(_entities[0].properties[3]);

  /// see [Chapter.chapterDescrip]
  static final chapterDescrip =
      QueryStringProperty<Chapter>(_entities[0].properties[4]);

  /// see [Chapter.chapterName]
  static final chapterName =
      QueryStringProperty<Chapter>(_entities[0].properties[5]);

  /// see [Chapter.quesNum]
  static final quesNum =
      QueryIntegerProperty<Chapter>(_entities[0].properties[6]);

  /// see [Chapter.quesTime]
  static final quesTime =
      QueryIntegerProperty<Chapter>(_entities[0].properties[7]);

  /// see [Chapter.progress]
  static final progress =
      QueryIntegerProperty<Chapter>(_entities[0].properties[8]);
}

/// [FirebaseLocalNotification] entity fields to define ObjectBox queries.
class FirebaseLocalNotification_ {
  /// see [FirebaseLocalNotification.id]
  static final id = QueryIntegerProperty<FirebaseLocalNotification>(
      _entities[1].properties[0]);

  /// see [FirebaseLocalNotification.isLive]
  static final isLive = QueryStringProperty<FirebaseLocalNotification>(
      _entities[1].properties[1]);

  /// see [FirebaseLocalNotification.dataTitle]
  static final dataTitle = QueryStringProperty<FirebaseLocalNotification>(
      _entities[1].properties[2]);

  /// see [FirebaseLocalNotification.dataBody]
  static final dataBody = QueryStringProperty<FirebaseLocalNotification>(
      _entities[1].properties[3]);

  /// see [FirebaseLocalNotification.dataLink]
  static final dataLink = QueryStringProperty<FirebaseLocalNotification>(
      _entities[1].properties[4]);

  /// see [FirebaseLocalNotification.dataImageLink]
  static final dataImageLink = QueryStringProperty<FirebaseLocalNotification>(
      _entities[1].properties[5]);
}

/// [HighScore] entity fields to define ObjectBox queries.
class HighScore_ {
  /// see [HighScore.id]
  static final id = QueryIntegerProperty<HighScore>(_entities[2].properties[0]);

  /// see [HighScore.coursecode]
  static final coursecode =
      QueryStringProperty<HighScore>(_entities[2].properties[1]);

  /// see [HighScore.chapterName]
  static final chapterName =
      QueryStringProperty<HighScore>(_entities[2].properties[2]);

  /// see [HighScore.score]
  static final score =
      QueryStringProperty<HighScore>(_entities[2].properties[3]);
}

/// [Question] entity fields to define ObjectBox queries.
class Question_ {
  /// see [Question.id]
  static final id = QueryIntegerProperty<Question>(_entities[3].properties[0]);

  /// see [Question.courseId]
  static final courseId =
      QueryIntegerProperty<Question>(_entities[3].properties[1]);

  /// see [Question.chapterId]
  static final chapterId =
      QueryIntegerProperty<Question>(_entities[3].properties[2]);

  /// see [Question.question]
  static final question =
      QueryStringProperty<Question>(_entities[3].properties[3]);

  /// see [Question.correctAnswer]
  static final correctAnswer =
      QueryStringProperty<Question>(_entities[3].properties[4]);

  /// see [Question.solution]
  static final solution =
      QueryStringProperty<Question>(_entities[3].properties[5]);

  /// see [Question.option2]
  static final option2 =
      QueryStringProperty<Question>(_entities[3].properties[6]);

  /// see [Question.option3]
  static final option3 =
      QueryStringProperty<Question>(_entities[3].properties[7]);

  /// see [Question.option4]
  static final option4 =
      QueryStringProperty<Question>(_entities[3].properties[8]);

  /// see [Question.isRead]
  static final isRead =
      QueryStringProperty<Question>(_entities[3].properties[9]);
}

/// [RegCourse] entity fields to define ObjectBox queries.
class RegCourse_ {
  /// see [RegCourse.courseId]
  static final courseId =
      QueryIntegerProperty<RegCourse>(_entities[4].properties[0]);

  /// see [RegCourse.courseName]
  static final courseName =
      QueryStringProperty<RegCourse>(_entities[4].properties[1]);

  /// see [RegCourse.coursecode]
  static final coursecode =
      QueryStringProperty<RegCourse>(_entities[4].properties[2]);

  /// see [RegCourse.courseDescrip]
  static final courseDescrip =
      QueryStringProperty<RegCourse>(_entities[4].properties[3]);

  /// see [RegCourse.expireAt]
  static final expireAt =
      QueryStringProperty<RegCourse>(_entities[4].properties[4]);

  /// see [RegCourse.courseImage]
  static final courseImage =
      QueryStringProperty<RegCourse>(_entities[4].properties[5]);

  /// see [RegCourse.progress]
  static final progress =
      QueryIntegerProperty<RegCourse>(_entities[4].properties[6]);

  /// see [RegCourse.courseChatLink]
  static final courseChatLink =
      QueryStringProperty<RegCourse>(_entities[4].properties[7]);

  /// see [RegCourse.courseMaterialLink]
  static final courseMaterialLink =
      QueryStringProperty<RegCourse>(_entities[4].properties[8]);

  /// see [RegCourse.id]
  static final id = QueryIntegerProperty<RegCourse>(_entities[4].properties[9]);
}

/// [Status] entity fields to define ObjectBox queries.
class Status_ {
  /// see [Status.id]
  static final id = QueryIntegerProperty<Status>(_entities[5].properties[0]);

  /// see [Status.url]
  static final url = QueryStringProperty<Status>(_entities[5].properties[1]);

  /// see [Status.type]
  static final type = QueryStringProperty<Status>(_entities[5].properties[2]);

  /// see [Status.time]
  static final time = QueryIntegerProperty<Status>(_entities[5].properties[3]);

  /// see [Status.caption]
  static final caption =
      QueryStringProperty<Status>(_entities[5].properties[4]);

  /// see [Status.shown]
  static final shown = QueryStringProperty<Status>(_entities[5].properties[5]);

  /// see [Status.level]
  static final level = QueryStringProperty<Status>(_entities[5].properties[6]);
}
