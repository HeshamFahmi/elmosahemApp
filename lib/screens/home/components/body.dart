import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/async_progress_dialog.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../cart/cart_screen.dart';
import '../../category_products/category_products_screen.dart';
import '../../product_details/product_details_screen.dart';
import '../../search_result/search_result_screen.dart';
import '../../../services/authentification/authentification_service.dart';
import '../../../services/data_streams/all_products_stream.dart';
import '../../../services/data_streams/favourite_products_stream.dart';
import '../../../services/database/product_database_helper.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../utils.dart';
import '../components/home_header.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";
const String DESCRIPTION = "description";

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: "assets/categories/return-on-investment.png",
      TITLE_KEY: "استثمار",
      PRODUCT_TYPE_KEY: ProductType.Investment,
      DESCRIPTION: "احصل على افضل استثمارات مع المساهم الان"
    },
    <String, dynamic>{
      ICON_KEY: "assets/categories/fortune-wheel.png",
      TITLE_KEY: "يناصيب",
      PRODUCT_TYPE_KEY: ProductType.Lottery,
      DESCRIPTION: "احصل على افضل الحظوظ والهدايا"
    },
    <String, dynamic>{
      ICON_KEY: "assets/categories/machinery.png",
      TITLE_KEY: "معدات ثقيله",
      PRODUCT_TYPE_KEY: ProductType.Heavy_Equipment,
      DESCRIPTION: "افضل المعدات المتاحه الثفيله"
    },
    <String, dynamic>{
      ICON_KEY: "assets/categories/other.png",
      TITLE_KEY: "اخرى",
      PRODUCT_TYPE_KEY: ProductType.Others,
      DESCRIPTION: "والكثير الكثير من المنتجات والجوائز فى انتظارك"
    },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    super.initState();

    favouriteProductsStream.init();
    allProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(screenPadding)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: getProportionateScreenHeight(15)),
                HomeHeader(
                  onSearchSubmitted: (value) async {
                    final query = value.toString();
                    if (query.length <= 0) return;
                    List<String> searchedProductsId;
                    try {
                      searchedProductsId = await ProductDatabaseHelper()
                          .searchInProducts(query.toLowerCase());
                      if (searchedProductsId != null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultScreen(
                              searchQuery: query,
                              searchResultProductsId: searchedProductsId,
                              searchIn: "كل الخدمات",
                            ),
                          ),
                        );
                        await refreshPage();
                      } else {
                        throw "تعذر البحث حاول مره اخري";
                      }
                    } catch (e) {
                      final error = e.toString();
                      Logger().e(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$error"),
                        ),
                      );
                    }
                  },
                  onCartButtonPressed: () async {
                    bool allowed =
                        AuthentificationService().currentUserVerified;
                    if (!allowed) {
                      final reverify = await showConfirmationDialog(context,
                          "لم تم بتفعيل البريد الاكتروني برجاء التفعيل",
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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                    await refreshPage();
                  },
                ),
                // MaterialButton(onPressed: () {
                //   FirebaseAuth.instance.authStateChanges().listen((User user) {
                //     if (user != null) {
                //       print(user.uid);
                //     }
                //   });
                // }),
                SizedBox(height: getProportionateScreenHeight(15)),
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.1,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 4),
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       physics: BouncingScrollPhysics(),
                //       children: [
                //         ...List.generate(
                //           productCategories.length,
                //           (index) {
                //             return Padding(
                //               padding: EdgeInsets.only(left: 10, right: 10),
                //               child: ProductTypeBox(
                //                 icon: productCategories[index][ICON_KEY],
                //                 title: productCategories[index][TITLE_KEY],
                //                 onPress: () {
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) =>
                //                           CategoryProductsScreen(
                //                         productType: productCategories[index]
                //                             [PRODUCT_TYPE_KEY],
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               ),
                //             );
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(height: getProportionateScreenHeight(20)),
                StreamBuilder<User>(
                    stream: AuthentificationService().userChanges,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final user = snapshot.data;
                        return Text(
                          "مرحبا ${user.displayName ?? "No Name"}",
                          style: headingStyle,
                        );
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
                SizedBox(height: getProportionateScreenHeight(20)),

                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: productCategories.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductsScreen(
                                  productType: productCategories[index]
                                      [PRODUCT_TYPE_KEY],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: kSecondaryColor.withOpacity(0.1)),
                            child: ListTile(
                                leading: Image.asset(
                                    productCategories[index][ICON_KEY]),
                                trailing: Icon(Icons.arrow_forward_ios_rounded),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productCategories[index][TITLE_KEY],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: kPrimaryColor),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      productCategories[index][DESCRIPTION],
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0,
                                          color: kPrimaryColor),
                                    )
                                  ],
                                )),
                          ),
                        );
                      }),
                ),

                SizedBox(height: getProportionateScreenHeight(20)),

                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 250,
                            color: kSecondaryColor.withOpacity(0.1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'المساهم هو تطبيق لبيع المنتجات وايضا لاقسام الاستثمار والتجاره والكثير من الاقسام المتاحه المفيده للمستخدم لدينا',
                                      style: headingStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    " اعرف نبـذه عــن المســاهــم !!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: kPrimaryColor),
                  ),
                )
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.35,
                //   child: ProductsSection(
                //     screenName: Favorite(),
                //     sectionTitle: "اعجبك",
                //     productsStreamController: favouriteProductsStream,
                //     emptyListMessage: "اضف الي قائمه المفضله",
                //     onProductCardTapped: onProductCardTapped,
                //   ),
                // ),
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.35,
                //   child: ProductsSection(
                //     screenName: AllProducts(),
                //     sectionTitle: "تفقد جميع الخدمات",
                //     productsStreamController: allProductsStream,
                //     emptyListMessage: "لا يوجد خدمات حاليه عاود مره اخري",
                //     onProductCardTapped: onProductCardTapped,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
