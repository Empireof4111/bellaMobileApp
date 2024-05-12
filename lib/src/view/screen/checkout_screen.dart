// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_in_if_null_operators, avoid_print
import 'dart:convert';
import 'package:bella_banga/src/model/userModel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/order_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/src/model/local_storage_model/addtocartmodel.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/Checkout';
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

List<Map<String, dynamic>> newExchangeRates = [];
late String currencyProductCode;

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    fetchAllFxRate();
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    setState(() {
      newExchangeRates = exchangeRates;
    });
  }

  late double totalPrice = 0.0;

  void calculateTotalPrice() {
    double newTotalPrice = 0.0;
    for (int index = 0; index < cartBox.length; index++) {
      Addtocartmodel addtocartmodel = cartBox.getAt(index);
      newTotalPrice +=
          addtocartmodel.productPrice * addtocartmodel.productQuantity;
      currencyProductCode = addtocartmodel.cartCurrencyCode;
    }

    setState(() {
      totalPrice = newTotalPrice;
    });
  }

  late double totalShippingFee = 0.0;
  void calculateTotalShippingFee() {
    double newTotalPrice = 0.0;
    for (int index = 0; index < cartBox.length; index++) {
      Addtocartmodel addtocartmodel = cartBox.getAt(index);
      newTotalPrice += addtocartmodel.cartShippingFee;
    }

    setState(() {
      totalShippingFee = newTotalPrice;
    });
  }

  late double totalServiceCharge = 0.0;
  void calculateTotalServcieCharge() {
    double newTotalPrice = 0.0;
    for (int index = 0; index < cartBox.length; index++) {
      Addtocartmodel addtocartmodel = cartBox.getAt(index);
      newTotalPrice += addtocartmodel.cartServiceCharged;
    }

    setState(() {
      totalServiceCharge = newTotalPrice;
    });
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: double.infinity,
            height: 20,
            child: Center(
                child: Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        );
      },
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    double? totalAmount = basedCurrencyConvertion(currencyChoosed,
        (totalPrice + totalShippingFee + totalServiceCharge), newExchangeRates);
    int resOrderId = 0;

    //FLUTTERWAVE CONFIG
    handlePaymentInitialization(double payAmount) async {
      final Customer customer = Customer(
          email: user.email.toString(),
          name: user.name,
          phoneNumber: user.mobile);
      final now = DateTime.now();
      final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: "FLWPUBK_TEST-3f74bf90d07b6f3be179d49f5ed7b87e-X",
          currency: currencyChoosed,
          redirectUrl: "www.zomo.com",
          txRef: now.toString(),
          amount: payAmount.toString(),
          customer: customer,
          paymentOptions: "ussd, card, barter, payattitude",
          customization: Customization(
            title: "Bellabanga",
            description: "Payment for items in cart",
            logo: "assets/images/mainLogo.png",
          ),
          isTestMode: true);
      final ChargeResponse response = await flutterwave.charge();
      if (response.status == "cancelled") {
        await OrderServices.cancelledOrder(resOrderId);
        showLoading(response.status.toString());
      } else {
        showLoading(response.status.toString());
      }
    }

    List<Map<String, dynamic>> extractDataFromModel(
        Addtocartmodel addtocartmodel) {
      List<Map<String, dynamic>> dataList = [
        {
          "id": addtocartmodel.id,
          "quantity": addtocartmodel.productQuantity,
          "color": addtocartmodel.productColor,
          "size": addtocartmodel.productSize,
        }
      ];

      return dataList;
    }

    List<Map<String, dynamic>> processCartBox(Box cartBox) {
      List<Map<String, dynamic>> result = [];
      for (int i = 0; i < cartBox.length; i++) {
        List<Map<String, dynamic>> extractedData =
            extractDataFromModel(cartBox.getAt(i));
        result.addAll(extractedData);
      }
      return result;
    }

    List<Map<String, dynamic>> finalResult = processCartBox(cartBox);

    //  PROCEED ORDER
    proceedOrder() async {
      var payload = {
        "customerName": user.name,
        "emailAddress": user.email,
        "phoneNumber": user.mobile,
        "paymentOption": "CARD",
        "currencyCode": currencyChoosed,
        "country": user.country,
        "state": user.city,
        "address": user.country,
        "tax": 0,
        "note": "",
        "products": finalResult,
      };
      // print(payload);
      try {
        http.Response response = await OrderServices.placeOrder(payload);
        print(jsonDecode(response.body));
        if (response.statusCode == 200) {
          int orderId = jsonDecode(response.body)['payload']['id'];
          resOrderId = orderId;
          handlePaymentInitialization(
              jsonDecode(response.body)['payload']['totalAmount']);
        } else {
          print('Falied to initialized Order');
        }
      } catch (e) {
        print(e);
      }
    }

    calculateTotalPrice();
    calculateTotalShippingFee();
    calculateTotalServcieCharge();

    MoneyFormatter newTotalprice = MoneyFormatter(
        amount: basedCurrencyConvertion(
                currencyProductCode, totalPrice, newExchangeRates)!
            .toDouble());
    MoneyFormatter newTotalShippingFee = MoneyFormatter(
        amount: basedCurrencyConvertion(
                currencyProductCode, totalShippingFee, newExchangeRates)!
            .toDouble());
    MoneyFormatter newTotalServiceFee = MoneyFormatter(
        amount: basedCurrencyConvertion(
                currencyProductCode, totalServiceCharge, newExchangeRates)!
            .toDouble());
    MoneyFormatter newTotalAmount = MoneyFormatter(
        amount: basedCurrencyConvertion(
                currencyProductCode, totalAmount!, newExchangeRates)!
            .toDouble());
    // ignore: unrelated_type_equality_checks
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.lightOrange,
        title: const Text('Check Out',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Text(
                    "Order list",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ListView.builder(
                shrinkWrap: true,
                itemCount: cartBox.length,
                itemBuilder: (context, index) {
                  Addtocartmodel addtocartmodel = cartBox.getAt(index);
                  return CartCard(
                    cartImage: addtocartmodel.cartImageUrl,
                    cartProductName: addtocartmodel.productName,
                    cartProductSize: addtocartmodel.productSize,
                    cartProductQuantity: addtocartmodel.productQuantity,
                    cartProductPrice: addtocartmodel.productPrice,
                    cartColor: addtocartmodel.productColor,
                    shippingFees: addtocartmodel.cartShippingFee,
                    currencyCode: addtocartmodel.cartCurrencyCode,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Shipping address",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //Address Card

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
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
                                child: const Icon(
                                  Icons.home,
                                  color: AppColor.darkOrange,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 50),
                              const Text(
                                "Change",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${user.city}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${user.country}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //End promo code card

            const SizedBox(
              height: 20,
            ),
            //End Address
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Bill Deatils",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Bill Details Card

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BillDetailsCard(
                              title: 'Total price',
                              price:
                                  "${currencySymbolConveeter(currencyChoosed)}${newTotalprice.output.nonSymbol}"),
                          BillDetailsCard(
                              title: 'Shipping fee',
                              price:
                                  "${currencySymbolConveeter(currencyChoosed)}${newTotalShippingFee.output.nonSymbol}"),
                          BillDetailsCard(
                              title: 'Service Charges',
                              price:
                                  "${currencySymbolConveeter(currencyChoosed)}${newTotalServiceFee.output.nonSymbol}"),
                          const Divider(
                            height: 30,
                            thickness: 2,
                          ),
                          BillDetailsCard(
                            title: 'Total Amount',
                            price:
                                "${currencySymbolConveeter(currencyChoosed)}${newTotalAmount.output.nonSymbol}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: isLoading
                  ? const Center(
                      child: MyProgressor(),
                    )
                  : DefaultButton(
                      text: "Continue",
                      press: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await proceedOrder();
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() {
                          isLoading = false;
                        });
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({
    super.key,
    required this.title,
    required this.price,
  });

  final String title;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColor.darkGrey,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        newExchangeRates.isEmpty
            ? const Text('Loading...')
            : Text(
                price,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
      ],
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
  final String cartColor;
  final String currencyCode;
  CartCard({
    super.key,
    required this.cartImage,
    required this.cartProductName,
    required this.cartProductSize,
    required this.cartProductQuantity,
    required this.cartProductPrice,
    required this.shippingFees,
    required this.cartColor,
    required this.currencyCode,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    MoneyFormatter absCartprice = MoneyFormatter(
        amount: basedCurrencyConvertion(widget.currencyCode.toString(),
                widget.cartProductPrice, newExchangeRates)!
            .toDouble());
    MoneyFormatter finalTotal = MoneyFormatter(
        amount: basedCurrencyConvertion(
                widget.currencyCode.toString(),
                ((widget.cartProductPrice * widget.cartProductQuantity) +
                    (widget.shippingFees)),
                newExchangeRates)!
            .toDouble());

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
                  color: AppColor.lightGrey,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cartProductName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
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
                        newExchangeRates.isNotEmpty
                            ? RichText(
                                text: TextSpan(
                                  text:
                                      currencySymbolConveeter(currencyChoosed),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: absCartprice.output.nonSymbol,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            " x ${widget.cartProductQuantity.toString()}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              )
                            : const Text('...'),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: newExchangeRates.isEmpty
                              ? const Text('Loading...')
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      currencySymbolConveeter(currencyChoosed),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      finalTotal.output.nonSymbol,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
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
