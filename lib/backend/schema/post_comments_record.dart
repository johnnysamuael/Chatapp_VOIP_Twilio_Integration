import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'post_comments_record.g.dart';

abstract class PostCommentsRecord
    implements Built<PostCommentsRecord, PostCommentsRecordBuilder> {
  static Serializer<PostCommentsRecord> get serializer =>
      _$postCommentsRecordSerializer;

  @nullable
  DateTime get timePosted;

  @nullable
  String get comment;

  @nullable
  DocumentReference get user;

  @nullable
  DocumentReference get post;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostCommentsRecordBuilder builder) =>
      builder..comment = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('postComments');

  static Stream<PostCommentsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostCommentsRecord._();
  factory PostCommentsRecord(
          [void Function(PostCommentsRecordBuilder) updates]) =
      _$PostCommentsRecord;

  static PostCommentsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPostCommentsRecordData({
  DateTime timePosted,
  String comment,
  DocumentReference user,
  DocumentReference post,
}) =>
    serializers.toFirestore(
        PostCommentsRecord.serializer,
        PostCommentsRecord((p) => p
          ..timePosted = timePosted
          ..comment = comment
          ..user = user
          ..post = post));
