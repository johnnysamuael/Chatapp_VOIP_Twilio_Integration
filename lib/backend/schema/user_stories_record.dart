import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_stories_record.g.dart';

abstract class UserStoriesRecord
    implements Built<UserStoriesRecord, UserStoriesRecordBuilder> {
  static Serializer<UserStoriesRecord> get serializer =>
      _$userStoriesRecordSerializer;

  @nullable
  DocumentReference get user;

  @nullable
  String get storyVideo;

  @nullable
  String get storyPhoto;

  @nullable
  String get storyDescription;

  @nullable
  DateTime get storyPostedAt;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  int get numComments;

  @nullable
  bool get isOwner;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserStoriesRecordBuilder builder) => builder
    ..storyVideo = ''
    ..storyPhoto = ''
    ..storyDescription = ''
    ..likes = ListBuilder()
    ..numComments = 0
    ..isOwner = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userStories');

  static Stream<UserStoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserStoriesRecord._();
  factory UserStoriesRecord([void Function(UserStoriesRecordBuilder) updates]) =
      _$UserStoriesRecord;

  static UserStoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserStoriesRecordData({
  DocumentReference user,
  String storyVideo,
  String storyPhoto,
  String storyDescription,
  DateTime storyPostedAt,
  int numComments,
  bool isOwner,
}) =>
    serializers.toFirestore(
        UserStoriesRecord.serializer,
        UserStoriesRecord((u) => u
          ..user = user
          ..storyVideo = storyVideo
          ..storyPhoto = storyPhoto
          ..storyDescription = storyDescription
          ..storyPostedAt = storyPostedAt
          ..likes = null
          ..numComments = numComments
          ..isOwner = isOwner));
