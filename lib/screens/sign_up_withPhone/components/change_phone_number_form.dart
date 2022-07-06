// ignore_for_file: non_constant_identifier_names

import 'package:elmosahem_app/services/authentification/authentification_service.dart';

import '../../../components/default_button.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ChangePhoneNumberForm extends StatefulWidget {
  const ChangePhoneNumberForm({
    Key key,
  }) : super(key: key);

  @override
  _ChangePhoneNumberFormState createState() => _ChangePhoneNumberFormState();
}

class _ChangePhoneNumberFormState extends State<ChangePhoneNumberForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController PhoneNumberController = TextEditingController();

  @override
  void dispose() {
    PhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          buildNewPhoneNumberField(),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          DefaultButton(
            text: "تسجيل الدخول",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                AuthentificationService()
                    .signupWithPhone(PhoneNumberController.text, context);
              }
            },
          ),
        ],
      ),
    );

    return form;
  }

  Widget buildNewPhoneNumberField() {
    return TextFormField(
      controller: PhoneNumberController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "ادخل رقم موبايل جديد",
        labelText: "رقم موبايل جديد",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (PhoneNumberController.text.isEmpty) {
          return "رقم الموبايل لا يمكن ان يكون فارغ";
        } else if (PhoneNumberController.text.length != 13) {
          return "مسموح بعشر ارقام فقط";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
