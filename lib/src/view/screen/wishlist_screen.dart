// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bella_banga/core/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/src/model/local_storage_model/addtocartmodel.dart';
import 'package:bella_banga/src/model/userModel.dart';
import 'package:bella_banga/src/model/whishlistModel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/wishlist_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  static const String routeName = "/wishlist";

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

List<WishListModel>? wishList;
final WishlistSerives wishListServices = WishlistSerives();
List<Map<String, dynamic>> newExchangeRates = [];

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    fetchAllFxRate();
    myWishList();
  }

  Future<void> myWishList() async {
    User user = Provider.of<UserProvider>(context).user;
    wishList = await wishListServices.userWishList(context, user.id as int);
    // setState(() {

    // });
  }

  void deleteListFunction(int id) async {
    await wishListServices.deleteWhishlist(id);
    setState(() {});
  }

  void deleteAllList() async {
    await wishListServices.deleteAllWhishlist();
    setState(() {});
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    newExchangeRates = exchangeRates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('My Wish List',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      body: FutureBuilder(
        future: myWishList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: MyProgressor());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading wishlist'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    wishList!.isEmpty
                        ? const NoWishListWidget()
                        : SizedBox(
                            height: 570,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    (wishList == null) ? 0 : wishList!.length,
                                itemBuilder: (context, index) {
                                  return WishListCard(
                                    productName: wishList![index].product!.name
                                        as String,
                                    productPrice: wishList![index]
                                        .product!
                                        .price as double,
                                    productSize: wishList![index].product!.sizes
                                        as String,
                                    productColor: wishList![index]
                                        .product!
                                        .colors as String,
                                    productImageLink: wishList![index]
                                        .product!
                                        .images!
                                        .split(',')[0]
                                        .toString(),
                                    addToCart: () {
                                      cartBox.put(
                                          wishList![index].product!.id,
                                          Addtocartmodel(
                                            id: wishList![index].product!.id
                                                as int,
                                            cartCurrencyCode: wishList![index]
                                                .product!
                                                .currencyCode as String,
                                            cartServiceCharged: wishList![index]
                                                .product!
                                                .serviceCharge as double,
                                            cartShippingFee: wishList![index]
                                                .product!
                                                .shippingFees as double,
                                            cartImageUrl: wishList![index]
                                                .product!
                                                .images!
                                                .split(',')[0]
                                                .toString(),
                                            productName: wishList![index]
                                                .product!
                                                .name
                                                .toString(),
                                            productColor: wishList![index]
                                                .product!
                                                .colors
                                                .toString(),
                                            productSize: wishList![index]
                                                .product!
                                                .sizes
                                                .toString(),
                                            productQuantity: 1,
                                            productPrice: wishList![index]
                                                .product!
                                                .price as double,
                                          ));
                                      deleteListFunction(
                                          wishList![index].info!.id as int);
                                      showSnackBar(
                                          context,
                                          wishList![index]
                                              .product!
                                              .name
                                              .toString());
                                    },
                                    deleteList: () {
                                      setState(() {
                                        deleteListFunction(
                                            wishList![index].info!.id as int);
                                      });
                                    },
                                    currencyType: wishList![index]
                                        .product!
                                        .currencyCode as String,
                                  );
                                })),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: wishList!.isEmpty ? false : true,
                      child: SizedBox(
                        width: 150,
                        child: DefaultButton(
                          text: 'Clear wishlist',
                          press: () {
                            deleteAllList();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class WishListCard extends StatefulWidget {
  final String productImageLink;
  final String productName;
  final double productPrice;
  final String productSize;
  final String productColor;
  final String currencyType;
  final GestureTapCallback addToCart;
  final GestureTapCallback deleteList;
  const WishListCard(
      {super.key,
      required this.productImageLink,
      required this.productName,
      required this.productPrice,
      required this.productSize,
      required this.productColor,
      required this.currencyType,
      required this.addToCart,
      required this.deleteList});

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  @override
  Widget build(BuildContext context) {
    MoneyFormatter finaAmount = MoneyFormatter(
        amount: basedCurrencyConvertion(
                widget.currencyType, widget.productPrice, newExchangeRates)!
            .toDouble());
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5)),
          boxShadow: const [
            BoxShadow(
              color: AppColor.lightGrey,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Row(
            children: [
              Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Image.network(
                      fit: BoxFit.fill,
                      scale: 1,
                      "$imageUrl${widget.productImageLink}")),
              const SizedBox(
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      newExchangeRates.isEmpty
                          ? const Text('Loading...')
                          : Row(
                              children: [
                                Text(
                                  currencySymbolConveeter(currencyChoosed),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  finaAmount.output.nonSymbol,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Color: ${widget.productColor}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Size: ${widget.productColor}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: widget.deleteList,
                          child: const Icon(
                            Icons.delete_outline,
                            size: 30,
                            color: Colors.red,
                          )),

                      // const SizedBox(height: 10,),
                      GestureDetector(
                          onTap: widget.addToCart,
                          child: const Icon(Icons.shopping_cart,
                              color: AppColor.darkOrange))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoWishListWidget extends StatelessWidget {
  const NoWishListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 130,
          ),
          SvgPicture.asset(
            'assets/icons/Online wishes list-bro.svg',
            height: 250,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Add Item to Wishlist',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange,
            ),
          ),
          const Text(
            'You have no whishlist yet.....',
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: DefaultButton(
                text: 'Add',
                press: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }),
          )
        ],
      ),
    );
  }
}
