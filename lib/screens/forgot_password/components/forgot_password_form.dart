import '../../../components/async_progress_dialog.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';

import '../../../components/no_account_text.dart';
import '../../../exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import '../../../exceptions/firebaseauth/credential_actions_exceptions.dart';
import '../../../services/authentification/authentification_service.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constants.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  @override
  void dispose() {
    emailFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "ارسل ايميل تأكيد",
            press: sendVerificationEmailButtonCallback,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailFieldController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "ادخل ايميل",
        labelText: "الايميل",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> sendVerificationEmailButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final String emailInput = emailFieldController.text.trim();
      bool resultStatus;
      String snackbarMessage;
      try {
        final resultFuture =
            AuthentificationService().resetPasswordForEmail(emailInput);
        resultFuture.then((value) => resultStatus = value);
        resultStatus = await showDialog(
          context: context,
          builder: (context) {
            return AsyncProgressDialog(
              resultFuture,
              message: Text("ارسال ايميل تفعيل"),
            );
          },
        );
        if (resultStatus == true) {
          snackbarMessage = "تم ارسال لينك تغيير كلمه السر لايميلك بنجاح";
        } else {
          throw FirebaseCredentialActionAuthUnknownReasonFailureException(
              message: "حدث خطأ حاول مره اخري");
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
