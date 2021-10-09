import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TwilioFirebaseUser {
  TwilioFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TwilioFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TwilioFirebaseUser> twilioFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TwilioFirebaseUser>((user) => currentUser = TwilioFirebaseUser(user));
