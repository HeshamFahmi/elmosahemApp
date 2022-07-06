import '../../../components/async_progress_dialog.dart';
import '../../../components/default_button.dart';
import '../../../services/authentification/authentification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class ChangeDisplayNameForm extends StatefulWidget {
  const ChangeDisplayNameForm({
    Key key,
  }) : super(key: key);

  @override
  _ChangeDisplayNameFormState createState() => _ChangeDisplayNameFormState();
}

class _ChangeDisplayNameFormState extends State<ChangeDisplayNameForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController newDisplayNameController =
      TextEditingController();

  final TextEditingController currentDisplayNameController =
      TextEditingController();

  @override
  void dispose() {
    newDisplayNameController.dispose();
    currentDisplayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          buildCurrentDisplayNameField(),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          buildNewDisplayNameField(),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
          DefaultButton(
            text: "تغيير اسم المستخدم",
            press: () {
              final uploadFuture = changeDisplayNameButtonCallback();
              showDialog(
                context: context,
                builder: (context) {
                  return AsyncProgressDialog(
                    uploadFuture,
                    message: Text("جاري تغيير الاسم"),
                  );
                },
              );
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("تم تغيير الاسم")));
            },
          ),
        ],
      ),
    );

    return form;
  }

  Widget buildNewDisplayNameField() {
    return TextFormField(
      controller: newDisplayNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "ادخل الاسم الجديد",
        labelText: "الاسم الجديد",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (newDisplayNameController.text.isEmpty) {
          return "الاسم لا يمكن ان يكون فارغ";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildCurrentDisplayNameField() {
    return StreamBuilder<User>(
      stream: AuthentificationService().userChanges,
      builder: (context, snapshot) {
        String displayName;
        if (snapshot.hasData && snapshot.data != null)
          displayName = snapshot.data.displayName;
        final textField = TextFormField(
          controller: currentDisplayNameController,
          decoration: InputDecoration(
            hintText: "لا يوجد اسم حالي",
            labelText: "الاسم الحالي",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.person),
          ),
          readOnly: true,
        );
        if (displayName != null)
          currentDisplayNameController.text = displayName;
        return textField;
      },
    );
  }

  Future<void> changeDisplayNameButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await AuthentificationService()
          .updateCurrentUserDisplayName(newDisplayNameController.text);
      print("تم تغيير الاسم الي ${newDisplayNameController.text} ...");
    }
  }
}
