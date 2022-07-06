import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../components/async_progress_dialog.dart';
import '../../constants.dart';
import '../../services/authentification/authentification_service.dart';
import '../../services/database/user_database_helper.dart';
import '../../utils.dart';
import '../about_developer/about_developer_screen.dart';
import '../change_display_name/change_display_name_screen.dart';
import '../change_display_picture/change_display_picture_screen.dart';
import '../change_email/change_email_screen.dart';
import '../change_national_id_picture/change_display_picture_screen.dart';
import '../change_password/change_password_screen.dart';
import '../change_phone/change_phone_screen.dart';
import '../change_selfie_picture/change_display_picture_screen.dart';
import '../edit_product/edit_product_screen.dart';
import '../manage_addresses/manage_addresses_screen.dart';
import '../my_orders/my_orders_screen.dart';
import '../my_products/my_products_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("الصفحه الشخصيه")),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            StreamBuilder<User>(
                stream: AuthentificationService().userChanges,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return buildUserAccountsHeader(user);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  }
                }),
            buildEditAccountExpansionTile(context),
            ListTile(
              leading: Icon(Icons.edit_location),
              title: Text(
                "اداره العناوين",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () async {
                bool allowed = AuthentificationService().currentUserVerified;
                if (!allowed) {
                  final reverify = await showConfirmationDialog(context,
                      "لم تقم بتفعيل الايميل برجاء التفعيل و المحاوله مره اخري",
                      positiveResponse: "اعاده ارسال ايميل تفعيل",
                      negativeResponse: "عوده للخلف");
                  if (reverify) {
                    final future = AuthentificationService()
                        .sendVerificationEmailToCurrentUser();
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AsyncProgressDialog(
                          future,
                          message: Text("اعاده ارسال ايميل التفعيل"),
                        );
                      },
                    );
                  }
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageAddressesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_location),
              title: Text(
                "طلباتى",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () async {
                bool allowed = AuthentificationService().currentUserVerified;
                if (!allowed) {
                  final reverify = await showConfirmationDialog(context,
                      "لم تقم بتفعيل الايميل برجاء التفعيل و المحاوله مره اخري",
                      positiveResponse: "اعاده ارسال ايميل تفعيل",
                      negativeResponse: "عوده للخلف");
                  if (reverify) {
                    final future = AuthentificationService()
                        .sendVerificationEmailToCurrentUser();
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AsyncProgressDialog(
                          future,
                          message: Text("اعاده ارسال ايميل التفعيل"),
                        );
                      },
                    );
                  }
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrdersScreen(),
                  ),
                );
              },
            ),
            buildSellerExpansionTile(context),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "عن المطور",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutDeveloperScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "تسجيل الخروج",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () async {
                final confirmation = await showConfirmationDialog(
                    context, "هل متأكد من تسجيل الخروج؟");
                if (confirmation) AuthentificationService().signOut(context);
              },
            ),
          ]),
        ));
  }

  UserAccountsDrawerHeader buildUserAccountsHeader(User user) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: kTextColor.withOpacity(0.15),
      ),
      accountEmail: Text(
        user.email ?? "No Email",
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      accountName: Text(
        user.displayName ?? "No Name",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      currentAccountPicture: FutureBuilder(
        future: UserDatabaseHelper().displayPictureForCurrentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          return CircleAvatar(
            backgroundColor: kTextColor,
          );
        },
      ),
    );
  }

  Widget buildEditAccountExpansionTile(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.person),
      title: Text(
        "تعديل الحساب",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      children: [
        ListTile(
          title: Text(
            "تغيير صوره الشخصيه",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeDisplayPictureScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير صوره بطاقه الرقم القومى",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNationalIdPictureScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير الصوره السيلفى",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeSelfiePictureScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير اسم المستخدم",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeDisplayNameScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير رقم الموبايل",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePhoneScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير الايميل",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeEmailScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "تغيير كلمه السر",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ));
          },
        ),
      ],
    );
  }

  Widget buildSellerExpansionTile(BuildContext context) {
    return FirebaseAuth.instance.currentUser.uid ==
            "gkzf0QRv79Nsou1Fk7KB2Tg53Yr1"
        ? ExpansionTile(
            leading: Icon(Icons.business),
            title: Text(
              "الخدمات",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            children: [
              ListTile(
                title: Text(
                  "اضف خدمه جديده",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                onTap: () async {
                  bool allowed = AuthentificationService().currentUserVerified;
                  if (!allowed) {
                    final reverify = await showConfirmationDialog(context,
                        "لم يتم تاكيد الايميل الخاص بك برجاء التاكيد و المحاوله مره اخري",
                        positiveResponse: "اعد ارسال ايميل التفعيل",
                        negativeResponse: "عوده للخلف");
                    if (reverify) {
                      final future = AuthentificationService()
                          .sendVerificationEmailToCurrentUser();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AsyncProgressDialog(
                            future,
                            message: Text("اعاده ارسال ايميل التفعيل"),
                          );
                        },
                      );
                    }
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProductScreen()));
                },
              ),
              ListTile(
                title: Text(
                  "اداره خدماتي",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                onTap: () async {
                  bool allowed = AuthentificationService().currentUserVerified;
                  if (!allowed) {
                    final reverify = await showConfirmationDialog(context,
                        "لم يتم تأكيد حسابك برجاء التأكيد و المحاوله مره اخري",
                        positiveResponse: "اعد ارسال ايميل التفعيل",
                        negativeResponse: "عوده للخلف");
                    if (reverify) {
                      final future = AuthentificationService()
                          .sendVerificationEmailToCurrentUser();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AsyncProgressDialog(
                            future,
                            message: Text("اعاده ارسال ايميل التفعيل"),
                          );
                        },
                      );
                    }
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProductsScreen(),
                    ),
                  );
                },
              ),
            ],
          )
        : Container();
  }
}
