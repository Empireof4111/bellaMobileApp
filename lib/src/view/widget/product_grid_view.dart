// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison, use_build_context_synchronously
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/wishlist_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/core/app_color.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatefulWidget {
  final String productImgUrl;
  final String productTitle;
  final String currencyType;
  final double productPrice;
  final int productId;
  final GestureTapCallback press;
  const ProductGridView({
    super.key,
    required this.productImgUrl,
    required this.productTitle,
    required this.currencyType,
    required this.productPrice,
    required this.productId,
    required this.press,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  @override
  void initState() {
    super.initState();
    fetchAllFxRate();
    basedCurrencyConvertion(
        widget.currencyType, widget.productPrice, newExchangeRates);
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    newExchangeRates = exchangeRates;
    setState(() {});
  }
//7063853975

  List<Map<String, dynamic>> newExchangeRates = [];

  Widget _gridItemFooter(
    BuildContext context,
    double productPrice,
    String productTitle,
  ) {
    double absAmount = basedCurrencyConvertion(
            widget.currencyType, productPrice, newExchangeRates)!
        .toDouble();
    double discountAmount = absAmount + 5 * (absAmount / 100);
    MoneyFormatter fmf = MoneyFormatter(amount: absAmount);
    MoneyFormatter discountfmf = MoneyFormatter(amount: discountAmount);
// print(fmf.output.nonSymbol);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              clipBehavior: Clip.hardEdge,
              child: Text(
                productTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            newExchangeRates.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          // ignore: unnecessary_brace_in_string_interps
                          currencySymbolConveeter(currencyChoosed),
                          // "${currencyChoosed} ",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          // formatter.format(absAmount!.toStringAsFixed(2)),
                          (fmf.output.nonSymbol),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 3),
                      Visibility(
                        visible: true,
                        child: SizedBox(
                          width: 40,
                          child: Text(
                            "${currencySymbolConveeter(currencyChoosed)}${discountfmf.output.nonSymbol}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  )
                : const Text('Loading..')
          ],
        ),
      ),
    );
  }

  WishlistSerives wishlistSerives = WishlistSerives();
  void addWishList(int productId) async {
    await wishlistSerives.addWishList(productId);
    setState(() {});
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // User? user = Provider.of<UserProvider>(context).user;
    Widget gridItemHeader() {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: AppColor.darkOrange,
              ),
              width: 80,
              height: 30,
              alignment: Alignment.center,
              child: const Text(
                "20% OFF",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () async {
                  await Provider.of<UserProvider>(context, listen: false)
                          .isLoggedIn
                      ? addWishList(widget.productId)
                      : Navigator.pushNamed(
                          context,
                          LoginScreen.routeName,
                        );
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                }),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: widget.press,
      child: GridTile(
        header: gridItemHeader(),
        footer:
            _gridItemFooter(context, widget.productPrice, widget.productTitle),
        child: _gridItemBody(widget.productImgUrl),
      ),
    );
  }
}

Widget _gridItemBody(String productImgUrl) {
  return Container(
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: const Color(0xFFE5E6E8),
      borderRadius: BorderRadius.circular(5),
      // border: Border.all(width: 0.5, color: AppColor.lightGrey),
      boxShadow: const [
        BoxShadow(
          color: AppColor.lightGrey,
          blurRadius: 10.0, // soften the shadow
          spreadRadius: 0.02, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            0.0, // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Image.network(
      productImgUrl,
      fit: BoxFit.fitHeight,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset("assets/images/errorImage.png");
      },
    ),
  );
}
