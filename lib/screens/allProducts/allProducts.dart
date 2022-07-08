import 'package:elmosahem_app/constants.dart';
import 'package:elmosahem_app/screens/allProducts/productAllsection.dart';
import 'package:flutter/material.dart';

import '../../services/data_streams/all_products_stream.dart';
import '../../size_config.dart';
import '../product_details/product_details_screen.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    super.initState();

    allProductsStream.init();
  }

  @override
  void dispose() {
    allProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المنتجات",
          style: headingStyle,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(
            height: SizeConfig.screenHeight * 0.8,
            child: ProductAllsection(
              sectionTitle: "تفقد جميع الخدمات",
              productsStreamController: allProductsStream,
              emptyListMessage: "لا يوجد خدمات حاليه عاود مره اخري",
              onProductCardTapped: onProductCardTapped,
            ),
          ),
        ],
      )),
    );
  }

  Future<void> refreshPage() {
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
