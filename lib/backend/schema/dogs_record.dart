import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'dogs_record.g.dart';

abstract class DogsRecord implements Built<DogsRecord, DogsRecordBuilder> {
  static Serializer<DogsRecord> get serializer => _$dogsRecordSerializer;

  @nullable
  DocumentReference get userAssociation;

  @nullable
  String get dogPhoto;

  @nullable
  String get dogName;

  @nullable
  String get dogType;

  @nullable
  String get dogAge;

  @nullable
  String get dogBio;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(DogsRecordBuilder builder) => builder
    ..dogPhoto = ''
    ..dogName = ''
    ..dogType = ''
    ..dogAge = ''
    ..dogBio = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('dogs');

  static Stream<DogsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  DogsRecord._();
  factory DogsRecord([void Function(DogsRecordBuilder) updates]) = _$DogsRecord;

  static DogsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createDogsRecordData({
  DocumentReference userAssociation,
  String dogPhoto,
  String dogName,
  String dogType,
  String dogAge,
  String dogBio,
}) =>
    serializers.toFirestore(
        DogsRecord.serializer,
        DogsRecord((d) => d
          ..userAssociation = userAssociation
          ..dogPhoto = dogPhoto
          ..dogName = dogName
          ..dogType = dogType
          ..dogAge = dogAge
          ..dogBio = dogBio));
