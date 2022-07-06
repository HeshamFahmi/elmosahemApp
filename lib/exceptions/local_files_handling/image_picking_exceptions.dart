import 'local_file_handling_exception.dart';

class LocalImagePickingException extends LocalFileHandlingException {
  LocalImagePickingException(
      {String message = "Instance of ImagePickingException"})
      : super(message);
}

class LocalImagePickingInvalidImageException
    extends LocalImagePickingException {
  LocalImagePickingInvalidImageException({String message = "الصوره غير صالحه"})
      : super(message: message);
}

class LocalImagePickingFileSizeOutOfBoundsException
    extends LocalImagePickingException {
  LocalImagePickingFileSizeOutOfBoundsException(
      {String message = "ابعاد الصوره خاطئه"})
      : super(message: message);
}

class LocalImagePickingInvalidImageSourceException
    extends LocalImagePickingException {
  LocalImagePickingInvalidImageSourceException(
      {String message = "مصدر الصوره تالف"})
      : super(message: message);
}

class LocalImagePickingUnknownReasonFailureException
    extends LocalImagePickingException {
  LocalImagePickingUnknownReasonFailureException(
      {String message = "تعذر حاول مره اخري"})
      : super(message: message);
}
