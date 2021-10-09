import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

int likes(UserPostsRecord post) {
  return post.likes.length;
}

bool hasUploadedMedia(String mediaPath) {
  return mediaPath != null && mediaPath.isNotEmpty;
}
