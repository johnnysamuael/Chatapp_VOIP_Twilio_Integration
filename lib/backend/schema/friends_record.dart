import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'friends_record.g.dart';

abstract class FriendsRecord
    implements Built<FriendsRecord, FriendsRecordBuilder> {
  static Serializer<FriendsRecord> get serializer => _$friendsRecordSerializer;

  @nullable
  DocumentReference get follower;

  @nullable
  DocumentReference get followee;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FriendsRecordBuilder builder) => builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('friends');

  static Stream<FriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FriendsRecord._();
  factory FriendsRecord([void Function(FriendsRecordBuilder) updates]) =
      _$FriendsRecord;

  static FriendsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createFriendsRecordData({
  DocumentReference follower,
  DocumentReference followee,
}) =>
    serializers.toFirestore(
        FriendsRecord.serializer,
        FriendsRecord((f) => f
          ..follower = follower
          ..followee = followee));
