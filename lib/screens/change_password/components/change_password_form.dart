import '../../../components/async_progress_dialog.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import '../../../exceptions/firebaseauth/credential_actions_exceptions.dart';
import '../../../services/authentification/authentification_service.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(screenPadding)),
        child: Column(
          children: [
            buildCurrentPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildNewPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildConfirmNewPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "تغيير كلمه السر",
              press: () {
                final updateFuture = changePasswordButtonCallback();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AsyncProgressDialog(
                      updateFuture,
                      message: Text("جاري تغيير كلمه السر"),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConfirmNewPasswordFormField() {
    return TextFormField(
      controller: confirmNewPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "تأكيد كلمه السر الجديده",
        labelText: "تأكيد كلمه السر الجديده",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (confirmNewPasswordController.text != newPasswordController.text) {
          return "كلمتا السر لا تطابق";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildCurrentPasswordFormField() {
    return TextFormField(
      controller: currentPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "ادخل كلمه السر الحاليه",
        labelText: "كلمه السر الحاليه",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        return null;
      },
      autovalidateMode: AutovalidateMode.disabled,
    );
  }

  Widget buildNewPasswordFormField() {
    return TextFormField(
      controller: newPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "كلمه السر الجديده",
        labelText: "كلمه السر الجديده",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (newPasswordController.text.isEmpty) {
          return "كلمه السر لا يمكن ان تكون فارغه";
        } else if (newPasswordController.text.length < 8) {
          return "كلمه السر قصيره ";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> changePasswordButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final AuthentificationService authService = AuthentificationService();
      bool currentPasswordValidation = await authService
          .verifyCurrentUserPassword(currentPasswordController.text);
      if (currentPasswordValidation == false) {
        print("كلمه السر الحاليه خاطئه");
      } else {
        bool updationStatus = false;
        String snackbarMessage;
        try {
          updationStatus = await authService.changePasswordForCurrentUser(
              newPassword: newPasswordController.text);
          if (updationStatus == true) {
            snackbarMessage = "تم تغيير كلمه السر بنجاح";
          } else {
            throw FirebaseCredentialActionAuthUnknownReasonFailureException(
                message: "تعذر تغيير كلمه السر حاول مره اخري");
          }
        } on MessagedFirebaseAuthException catch (e) {
          snackbarMessage = e.message;
        } catch (e) {
          snackbarMessage = e.toString();
        } finally {
          Logger().i(snackbarMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarMessage),
            ),
          );
        }
      }
    }
  }
}
