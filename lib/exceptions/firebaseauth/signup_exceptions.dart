import 'messeged_firebaseauth_exception.dart';

class FirebaseSignUpAuthException extends MessagedFirebaseAuthException {
  FirebaseSignUpAuthException(
      {String message: "Instance of FirebaseSignUpAuthException"})
      : super(message);
}

class FirebaseSignUpAuthEmailAlreadyInUseException
    extends FirebaseSignUpAuthException {
  FirebaseSignUpAuthEmailAlreadyInUseException(
      {String message = "الايميل مستخدم بالفعل"})
      : super(message: message);
}

class FirebaseSignUpAuthInvalidEmailException
    extends FirebaseSignUpAuthException {
  FirebaseSignUpAuthInvalidEmailException({String message = "الايميل غير صالح"})
      : super(message: message);
}

class FirebaseSignUpAuthOperationNotAllowedException
    extends FirebaseSignUpAuthException {
  FirebaseSignUpAuthOperationNotAllowedException(
      {String message = "انشاء حساب محظور لهذا المستخدم"})
      : super(message: message);
}

class FirebaseSignUpAuthWeakPasswordException
    extends FirebaseSignUpAuthException {
  FirebaseSignUpAuthWeakPasswordException({String message = "كلمه السر ضعيفه"})
      : super(message: message);
}

class FirebaseSignUpAuthUnknownReasonFailureException
    extends FirebaseSignUpAuthException {
  FirebaseSignUpAuthUnknownReasonFailureException(
      {String message = "تعذر التسجيل حاول مره اخري"})
      : super(message: message);
}
