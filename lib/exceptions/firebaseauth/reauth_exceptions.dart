import 'messeged_firebaseauth_exception.dart';

class FirebaseReauthException extends MessagedFirebaseAuthException {
  FirebaseReauthException(
      {String message: "Instance of FirebaseReauthException"})
      : super(message);
}

class FirebaseReauthUserMismatchException extends FirebaseReauthException {
  FirebaseReauthUserMismatchException(
      {String message: "المستخدم لا يتطابق مع المستخدم الحالي"})
      : super(message: message);
}

class FirebaseReauthUserNotFoundException extends FirebaseReauthException {
  FirebaseReauthUserNotFoundException(
      {String message = "لا يوجد مستخدم بهذه البيانات"})
      : super(message: message);
}

class FirebaseReauthInvalidCredentialException extends FirebaseReauthException {
  FirebaseReauthInvalidCredentialException({String message = "بيانات خاطئه"})
      : super(message: message);
}

class FirebaseReauthInvalidEmailException extends FirebaseReauthException {
  FirebaseReauthInvalidEmailException({String message = "ايميل خاطئ"})
      : super(message: message);
}

class FirebaseReauthWrongPasswordException extends FirebaseReauthException {
  FirebaseReauthWrongPasswordException({String message = "كلمه السر خاطئه"})
      : super(message: message);
}

class FirebaseReauthInvalidVerificationCodeException
    extends FirebaseReauthException {
  FirebaseReauthInvalidVerificationCodeException(
      {String message = "كود تفعيل خاطئ"})
      : super(message: message);
}

class FirebaseReauthInvalidVerificationIdException
    extends FirebaseReauthException {
  FirebaseReauthInvalidVerificationIdException(
      {String message = "كود تفعيل خاطئ"})
      : super(message: message);
}

class FirebaseReauthUnknownReasonFailureException
    extends FirebaseReauthException {
  FirebaseReauthUnknownReasonFailureException(
      {String message = "تعذر اعاده تسجيل الدخول حاول مره اخري"})
      : super(message: message);
}
