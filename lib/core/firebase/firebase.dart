import 'package:firebase_auth/firebase_auth.dart';

abstract class Firebase {
  FirebaseAuth getAuth();
}

class FirebaseImpl implements Firebase {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  FirebaseAuth getAuth() {
    return auth;
  }
}
