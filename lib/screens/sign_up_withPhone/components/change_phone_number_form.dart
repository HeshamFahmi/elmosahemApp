// ignore_for_file: non_constant_identifier_names

import 'package:country_code_picker/country_code_picker.dart';
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

  String countryCode;

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

                AuthentificationService().signupWithPhone(
                    countryCode + PhoneNumberController.text, context);
              }
            },
          ),
        ],
      ),
    );

    return form;
  }

  Widget buildNewPhoneNumberField() {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: CountryCodePicker(
            onChanged: (value) {
              setState(() {
                countryCode = value.toString();
                print(countryCode);
              });
            },
            initialSelection: 'eg',
            favorite: ['+20', 'eg'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
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
              } else if (PhoneNumberController.text.length != 10) {
                return "مسموح بعشر ارقام فقط";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }
}
