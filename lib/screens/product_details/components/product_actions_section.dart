import '../../../components/async_progress_dialog.dart';
import '../../../components/top_rounded_container.dart';
import '../../../models/Product.dart';
import 'product_description.dart';
import '../provider_models/ProductActions.dart';
import '../../../services/authentification/authentification_service.dart';
import '../../../services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../utils.dart';

class ProductActionsSection extends StatelessWidget {
  final Product product;

  const ProductActionsSection({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        Stack(
          children: [
            TopRoundedContainer(
              child: ProductDescription(product: product),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: buildFavouriteButton(),
            ),
          ],
        ),
      ],
    );
    UserDatabaseHelper().isProductFavourite(product.id).then(
      (value) {
        final productActions =
            Provider.of<ProductActions>(context, listen: false);
        productActions.productFavStatus = value;
      },
    ).catchError(
      (e) {
        Logger().w("$e");
      },
    );
    return column;
  }

  Widget buildFavouriteButton() {
    return Consumer<ProductActions>(
      builder: (context, productDetails, child) {
        return InkWell(
          onTap: () async {
            bool allowed = AuthentificationService().currentUserVerified;
            if (!allowed) {
              final reverify = await showConfirmationDialog(context,
                  "لم يتم التحقيق من الايميل بعد . هذه الخدمه للمستخدمين المعروفين ققط",
                  positiveResponse: "اعد ارسال اميل التحقيق",
                  negativeResponse: "العوده للخلف");
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
            bool success = false;
            final future = UserDatabaseHelper()
                .switchProductFavouriteStatus(
                    product.id, !productDetails.productFavStatus)
                .then(
              (status) {
                success = status;
              },
            ).catchError(
              (e) {
                Logger().e(e.toString());
                success = false;
              },
            );
            await showDialog(
              context: context,
              builder: (context) {
                return AsyncProgressDialog(
                  future,
                  message: Text(
                    productDetails.productFavStatus
                        ? "مسح من المفضله"
                        : "اضافه الى المفضله",
                  ),
                );
              },
            );
            if (success) {
              productDetails.switchProductFavStatus();
            }
          },
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            decoration: BoxDecoration(
              color: productDetails.productFavStatus
                  ? Color(0xFFFFE6E6)
                  : Color(0xFFF5F6F9),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              child: Icon(
                Icons.favorite,
                color: productDetails.productFavStatus
                    ? Color(0xFFFF4848)
                    : Color(0xFFD8DEE4),
              ),
            ),
          ),
        );
      },
    );
  }
}
