import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/async_progress_dialog.dart';
import '../../../components/default_button.dart';
import '../../../services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
  final TextEditingController newPhoneNumberController =
      TextEditingController();
  final TextEditingController currentPhoneNumberController =
      TextEditingController();

  @override
  void dispose() {
    newPhoneNumberController.dispose();
    currentPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          buildCurrentPhoneNumberField(),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          buildNewPhoneNumberField(),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
          DefaultButton(
            text: "تغيير رقم الموبايل",
            press: () {
              final updateFuture = updatePhoneNumberButtonCallback();
              showDialog(
                context: context,
                builder: (context) {
                  return AsyncProgressDialog(
                    updateFuture,
                    message: Text("جاري تغيير رقم الموبايل"),
                  );
                },
              );
            },
          ),
        ],
      ),
    );

    return form;
  }

  Future<void> updatePhoneNumberButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      bool status = false;
      String snackbarMessage;
      try {
        status = await UserDatabaseHelper()
            .updatePhoneForCurrentUser(newPhoneNumberController.text);
        if (status == true) {
          snackbarMessage = "تم تغيير رقم الموبايل بنجاح";
        } else {
          throw "حدث خطأ حاول مره اخري";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "حدث خطأ حاول مره اخري";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = "حدث خطأ حاول مره اخري";
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

  Widget buildNewPhoneNumberField() {
    return TextFormField(
      controller: newPhoneNumberController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "ادخل رقم موبايل جديد",
        labelText: "رقم موبايل جديد",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (newPhoneNumberController.text.isEmpty) {
          return "رقم الموبايل لا يمكن ان يكون فارغ";
        } else if (newPhoneNumberController.text.length != 10) {
          return "مسموح بعشر ارقام فقط";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildCurrentPhoneNumberField() {
    return StreamBuilder<DocumentSnapshot>(
      stream: UserDatabaseHelper().currentUserDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        String currentPhone;
        if (snapshot.hasData && snapshot.data != null)
          currentPhone = snapshot.data[UserDatabaseHelper.PHONE_KEY];
        final textField = TextFormField(
          controller: currentPhoneNumberController,
          decoration: InputDecoration(
            hintText: "لا يوجد رقم حالي",
            labelText: "رقم الموبايل الحالي",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.phone),
          ),
          readOnly: true,
        );
        if (currentPhone != null)
          currentPhoneNumberController.text = currentPhone;
        return textField;
      },
    );
  }
}
