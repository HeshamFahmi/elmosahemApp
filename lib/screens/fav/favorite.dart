import 'package:elmosahem_app/screens/fav/productSection.dart';
import 'package:flutter/material.dart';

import '../../services/data_streams/all_products_stream.dart';
import '../../services/data_streams/favourite_products_stream.dart';
import '../../size_config.dart';
import '../product_details/product_details_screen.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();

  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    favouriteProductsStream.init();
    allProductsStream.init();
    super.initState();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضله"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(
            height: SizeConfig.screenHeight * 0.5,
            child: Productsection(
              productsStreamController: favouriteProductsStream,
              emptyListMessage: "اضف الي قائمه المفضله",
              onProductCardTapped: onProductCardTapped,
            ),
          ),
        ],
      )),
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
