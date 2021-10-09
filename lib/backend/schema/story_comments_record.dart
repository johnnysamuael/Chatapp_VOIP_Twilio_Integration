import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'story_comments_record.g.dart';

abstract class StoryCommentsRecord
    implements Built<StoryCommentsRecord, StoryCommentsRecordBuilder> {
  static Serializer<StoryCommentsRecord> get serializer =>
      _$storyCommentsRecordSerializer;

  @nullable
  DocumentReference get storyAssociation;

  @nullable
  DocumentReference get commentUser;

  @nullable
  String get comment;

  @nullable
  DateTime get timePosted;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StoryCommentsRecordBuilder builder) =>
      builder..comment = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('storyComments');

  static Stream<StoryCommentsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StoryCommentsRecord._();
  factory StoryCommentsRecord(
          [void Function(StoryCommentsRecordBuilder) updates]) =
      _$StoryCommentsRecord;

  static StoryCommentsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStoryCommentsRecordData({
  DocumentReference storyAssociation,
  DocumentReference commentUser,
  String comment,
  DateTime timePosted,
}) =>
    serializers.toFirestore(
        StoryCommentsRecord.serializer,
        StoryCommentsRecord((s) => s
          ..storyAssociation = storyAssociation
          ..commentUser = commentUser
          ..comment = comment
          ..timePosted = timePosted));
