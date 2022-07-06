import 'messeged_firebaseauth_exception.dart';

class FirebaseCredentialActionAuthException
    extends MessagedFirebaseAuthException {
  FirebaseCredentialActionAuthException(
      {String message = "Instance of FirebasePasswordActionAuthException"})
      : super(message);
}

class FirebaseCredentialActionAuthUserNotFoundException
    extends FirebaseCredentialActionAuthException {
  FirebaseCredentialActionAuthUserNotFoundException(
      {String message = "لا يوجد مستخدم بهذه البيانات"})
      : super(message: message);
}

class FirebaseCredentialActionAuthWeakPasswordException
    extends FirebaseCredentialActionAuthException {
  FirebaseCredentialActionAuthWeakPasswordException(
      {String message = "كلمه السر ضعيفه"})
      : super(message: message);
}

class FirebaseCredentialActionAuthRequiresRecentLoginException
    extends FirebaseCredentialActionAuthException {
  FirebaseCredentialActionAuthRequiresRecentLoginException(
      {String message = "سجل الدخول مجددا"})
      : super(message: message);
}

class FirebaseCredentialActionAuthUnknownReasonFailureException
    extends FirebaseCredentialActionAuthException {
  FirebaseCredentialActionAuthUnknownReasonFailureException(
      {String message = "تعذر حاول مره اخري"})
      : super(message: message);
}
