// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/model/local_storage_model/addtocartmodel.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/checkout_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_formatter/money_formatter.dart';

class CartBottomSheetScreen extends StatefulWidget {
  const CartBottomSheetScreen({super.key});

  static const String routeName = "/Cart_Screen";

  @override
  State<CartBottomSheetScreen> createState() => _CartBottomSheetScreenState();
}

// ignore: library_private_types_in_public_api
final GlobalKey<_CheckOutSectionState> checkoutSectionKey =
    GlobalKey<_CheckOutSectionState>();

List<Map<String, dynamic>> newExchangeRates = [];
String currencyProductCode = currencyChoosed;

class _CartBottomSheetScreenState extends State<CartBottomSheetScreen> {
  late double total = 0.0;
  void calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int index = 0; index < cartBox.length; index++) {
      Addtocartmodel addtocartmodel = cartBox.getAt(index);
      totalPrice +=
          addtocartmodel.productPrice * addtocartmodel.productQuantity;
      totalPrice += addtocartmodel.cartShippingFee; // Add shipping fee
      currencyProductCode = addtocartmodel.cartCurrencyCode.toString();
    }

    setState(() {
      total = totalPrice;
    });

    // Update CheckOutSection total
    checkoutSectionKey.currentState?.updateTotal(total);
  }

  @override
  void initState() {
    super.initState();
    fetchAllFxRate();
    calculateTotalPrice();
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    setState(() {
      newExchangeRates = exchangeRates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            cartBox.isEmpty
                ? const NoWishListWidget()
                : SizedBox(
                    height: 500,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartBox.length,
                        itemBuilder: (context, index) {
                          Addtocartmodel addtocartmodel = cartBox.getAt(index);
                          return CartCard(
                            cartImage: addtocartmodel.cartImageUrl,
                            cartProductName: addtocartmodel.productName,
                            cartColor: addtocartmodel.productColor,
                            cartProductSize: addtocartmodel.productSize,
                            cartProductPrice: addtocartmodel.productPrice,
                            total: total,
                            cartProductQuantity: addtocartmodel.productQuantity,
                            press: () {
                              setState(() {
                                cartBox.deleteAt(index);
                              });
                            },
                            shippingFees: addtocartmodel.cartShippingFee,
                            currencyCode: addtocartmodel.cartCurrencyCode,
                          );
                        }),
                  ),
            Visibility(
                visible: cartBox.isEmpty ? false : true,
                child: CheckOutSection(
                  totalPrice: total,
                  key: checkoutSectionKey,
                  currencyCode: currencyProductCode,
                )),
          ],
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
            'Add Item to cart',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange,
            ),
          ),
          const Text(
            'You have no item in the cart',
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

// ignore: must_be_immutable
class CartCard extends StatefulWidget {
  final String cartImage;
  final String cartProductName;
  final String cartProductSize;
  late int cartProductQuantity;
  late double cartProductPrice;
  late double shippingFees;
  late double total;
  final String cartColor;
  final String currencyCode;
  final GestureTapCallback press;
  CartCard({
    super.key,
    required this.cartImage,
    required this.cartProductName,
    required this.cartProductSize,
    required this.cartProductQuantity,
    required this.cartProductPrice,
    required this.cartColor,
    required this.press,
    required this.shippingFees,
    required this.total,
    required this.currencyCode,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  // Function to decrease quantity
  void decreaseQuantity() {
    if (widget.cartProductQuantity > 1) {
      setState(() {
        widget.cartProductQuantity -= 1;
      });
      updateCartBox();
      calculateTotalPrice();
    }
  }

  // Function to increase quantity
  void increaseQuantity() {
    setState(() {
      widget.cartProductQuantity += 1;
    });
    updateCartBox();
    calculateTotalPrice();
  }

  // Function to update cartBox with the new quantity
  void updateCartBox() {
    int index = cartBox.values.toList().indexWhere((element) =>
        element.productName == widget.cartProductName &&
        element.productSize == widget.cartProductSize &&
        element.productColor == widget.cartColor);

    if (index != -1) {
      // Update quantity in the cartBox
      Addtocartmodel updatedCartItem = cartBox.getAt(index)!;
      updatedCartItem.productQuantity = widget.cartProductQuantity;
      cartBox.putAt(index, updatedCartItem);
    }
  }

// Function to calculate the total price
  void calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int index = 0; index < cartBox.length; index++) {
      Addtocartmodel addtocartmodel = cartBox.getAt(index);
      totalPrice +=
          addtocartmodel.productPrice * addtocartmodel.productQuantity;
      totalPrice += addtocartmodel.cartShippingFee; // Add shipping fee
    }

    setState(() {
      widget.total = totalPrice;
    });
    // Update CheckOutSection total
    checkoutSectionKey.currentState?.updateTotal(widget.total);
  }

//disabling the add to cart button
  bool isButtonDisable = false;

  @override
  Widget build(BuildContext context) {
    double absAmount = basedCurrencyConvertion(
            widget.currencyCode, widget.cartProductPrice, newExchangeRates)!
        .toDouble();
    MoneyFormatter fmf = MoneyFormatter(amount: absAmount);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 90,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image.network(
                  imageUrl + widget.cartImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: 120,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cartProductName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                        GestureDetector(
                          onTap: widget.press,
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColor.darkOrange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            'Color: ${widget.cartColor} | Size: ${widget.cartProductSize}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        newExchangeRates.isEmpty
                            ? const Text('Loading...')
                            : Row(
                                children: [
                                  Text(
                                    currencySymbolConveeter(currencyChoosed),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (fmf.output.nonSymbol),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              splashRadius: 10.0,
                              onPressed: decreaseQuantity,
                              icon: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: AppColor.lightGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColor.darkOrange,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              widget.cartProductQuantity.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              splashRadius: 10.0,
                              onPressed: increaseQuantity,
                              icon: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: AppColor.lightGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColor.darkOrange,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CheckOutSection extends StatefulWidget {
  late double totalPrice;
  final String currencyCode;
  CheckOutSection({
    super.key,
    required this.totalPrice,
    required this.currencyCode,
  });

  @override
  State<CheckOutSection> createState() => _CheckOutSectionState();
}

class _CheckOutSectionState extends State<CheckOutSection> {
  void updateTotal(double newTotal) {
    setState(() {
      widget.totalPrice = newTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkoutSectionKey.currentState?.updateTotal(widget.totalPrice);
    double myNewTotal = basedCurrencyConvertion(
        widget.currencyCode, widget.totalPrice, newExchangeRates)!;
    MoneyFormatter fmf = MoneyFormatter(amount: myNewTotal);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
        ),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
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
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(color: AppColor.darkGrey),
                      ),
                      newExchangeRates.isEmpty
                          ? const Text('Loading...')
                          : Row(
                              children: [
                                Text(
                                  currencySymbolConveeter(currencyChoosed),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  fmf.output.nonSymbol,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                    ]),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        UserProvider userProvider = UserProvider();
                        await userProvider.isLoggedIn
                            ? Navigator.pushNamed(
                                context, CheckoutScreen.routeName)
                            : Navigator.pushNamed(
                                context, LoginScreen.routeName,
                                arguments: "checkOut");
                      },
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(100, 45)),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.lightOrange)),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(100, 45)),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.darkOrange)),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
