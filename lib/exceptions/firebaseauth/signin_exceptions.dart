import 'messeged_firebaseauth_exception.dart';

class FirebaseSignInAuthException extends MessagedFirebaseAuthException {
  FirebaseSignInAuthException(
      {String message: "Instance of FirebaseSignInAuthException"})
      : super(message);
}

class FirebaseSignInAuthUserDisabledException
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthUserDisabledException({String message = "تم حظر المستخدم"})
      : super(message: message);
}

class FirebaseSignInAuthUserNotFoundException
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthUserNotFoundException(
      {String message = "لا يوجد مستخدم بهذه البيانات"})
      : super(message: message);
}

class FirebaseSignInAuthInvalidEmailException
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthInvalidEmailException({String message = "ايميل خاطئ"})
      : super(message: message);
}

class FirebaseSignInAuthWrongPasswordException
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthWrongPasswordException({String message = "كلمه السر خاطئه"})
      : super(message: message);
}

class FirebaseTooManyRequestsException extends FirebaseSignInAuthException {
  FirebaseTooManyRequestsException(
      {String message = "الخادم مشغول برجاء المحاوله وقت لاحق"})
      : super(message: message);
}

class FirebaseSignInAuthUserNotVerifiedException
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthUserNotVerifiedException(
      {String message = "هذا المستخدم غير مفعل"})
      : super(message: message);
}

class FirebaseSignInAuthUnknownReasonFailure
    extends FirebaseSignInAuthException {
  FirebaseSignInAuthUnknownReasonFailure(
      {String message = "تعذر تسجيل الدخول حاول مره اخري"})
      : super(message: message);
}
