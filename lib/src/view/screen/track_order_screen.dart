// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bella_banga/src/view/screen/chat_Screen.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/model/orderDetailModel.dart';
import 'package:bella_banga/src/model/orderModel.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/order_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';

class TrackOrderScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final orderId;
  const TrackOrderScreen({super.key, this.orderId});
  static const String routeName = "/Track-Order";
  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<OrderDetailModel>? orderDetailList;
  List<OrderModel>? orderByIdList;
  final OrderServices orderServices = OrderServices();

  @override
  void initState() {
    super.initState();
    orderDeatail();
    orderByOrderId();
  }

  void orderDeatail() async {
    orderDetailList = await orderServices.orderDetail(context, widget.orderId);
    setState(() {});
  }

  void orderByOrderId() async {
    orderByIdList =
        await orderServices.getOrderByOrderId(context, widget.orderId);
    setState(() {});
  }

  bool isCancel = false;

  @override
  Widget build(BuildContext context) {
    String orderstatus(String stat) {
      late String myOrderStatus = '';
      if (stat == "CA") {
        myOrderStatus = 'Cancel';
        isCancel = true;
      } else if (stat == 'PP') {
        myOrderStatus = "Pending Payment";
        isCancel = true;
      } else {
        myOrderStatus = "Completed";
      }
      return myOrderStatus;
    }

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('Track Order',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      body: orderByIdList == null
          ? const Center(
              child: MyProgressor(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  orderDetailList == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
                              )),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderDetailList?.isEmpty ?? true
                              ? 0
                              : orderDetailList!.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(8)),
                              child: SizedBox(
                                height: 120,
                                child: ProductCard(
                                  orderStatus: orderDetailList![index]
                                      .details!
                                      .status
                                      .toString(),
                                  productName: orderDetailList![index]
                                      .product!
                                      .name
                                      .toString(),
                                  productColor: orderDetailList![index]
                                      .product!
                                      .colors
                                      .toString(),
                                  productSize: orderDetailList![index]
                                      .product!
                                      .sizes
                                      .toString(),
                                  productPrice: orderDetailList![index]
                                      .product!
                                      .price as double,
                                  vendorName: orderDetailList![index]
                                      .product!
                                      .vendorName
                                      .toString(),
                                  productImageUrl: orderDetailList![index]
                                      .product!
                                      .images!
                                      .split(',')[0],
                                  currencyType: orderDetailList![index]
                                      .product!
                                      .currencyCode
                                      .toString(),
                                  press: () {
                                    Navigator.pushNamed(
                                        context, ChatScreen.routeName);
                                  },
                                ),
                              ),
                            );
                          }),
                  //Stepper

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                          child: TimelineTile(
                            isFirst: true,
                            beforeLineStyle:
                                const LineStyle(color: AppColor.darkOrange),
                            indicatorStyle: IndicatorStyle(
                                color: AppColor.darkOrange,
                                iconStyle: IconStyle(
                                    iconData: Icons.done, color: Colors.white)),
                            endChild: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.transparent,
                              height: 100,
                              width: 50,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('Order Confirm',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('Order#2345768'),
                                  Text('9:00 PM June, 2023'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: TimelineTile(
                            isFirst: false,
                            isLast: false,
                            beforeLineStyle:
                                const LineStyle(color: AppColor.darkOrange),
                            indicatorStyle: const IndicatorStyle(
                                color: AppColor.darkOrange),
                            endChild: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.transparent,
                              height: 100,
                              width: 50,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('Order Confirm',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('Order#2345768'),
                                  Text('9:00 PM June, 2023'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: TimelineTile(
                            isLast: true,
                            beforeLineStyle:
                                const LineStyle(color: AppColor.darkOrange),
                            indicatorStyle: const IndicatorStyle(
                                color: AppColor.darkOrange),
                            endChild: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.transparent,
                              height: 100,
                              width: 50,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('Order Confirm',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('Order#2345768'),
                                  Text('9:00 PM June, 2023'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Order Detail",
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
                          height: 320,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.5)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Order'),
                                            Text(
                                                '#${orderByIdList?[0].orderReferenceId}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18)),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Shipping Fee'),
                                                Text(
                                                    '${currencySymbolConveeter(orderByIdList![0].currencyCode.toString())} ${orderByIdList?[0].shippingFees}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Transaction charges'),
                                            Text(
                                                '${currencySymbolConveeter(orderByIdList![0].currencyCode.toString())} ${orderByIdList?[0].totalSystemAmount}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18)),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Total Amount'),
                                                Text(
                                                    orderByIdList == null
                                                        ? "Loading.."
                                                        : '${currencySymbolConveeter(orderByIdList![0].currencyCode.toString())} ${orderByIdList![0].totalAmount!.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text('Order Status |'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        orderstatus(
                                            '${orderByIdList?[0].status}'),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 18)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('CUSTOMER DEATAILS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text('NAME: '),
                                Text('${orderByIdList?[0].customerName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14)),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text('RECEPIENT NO.: '),
                                Text(
                                    '${orderByIdList?[0].customerMobileNumber}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14)),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text('RECEPIENT ADDRESS: '),
                                Text('${orderByIdList?[0].address}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //End Address
                ],
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  final String productImageUrl;
  final String productName;
  final String productColor;
  final String productSize;
  final double productPrice;
  final String orderStatus;
  final String vendorName;
  final String currencyType;
  GestureTapCallback press;
  ProductCard({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.orderStatus,
    required this.vendorName,
    required this.currencyType,
    required this.press,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String orderstatus(String stat) {
    late String myOrderStatus = '';
    if (stat == "CA") {
      myOrderStatus = 'Cancel';
      isCancel = true;
    } else if (stat == 'PP') {
      myOrderStatus = "Pending Payment";
      isCancel = true;
    } else {
      myOrderStatus = "Completed";
    }
    return myOrderStatus;
  }

  bool isCancel = false;
  List<Map<String, dynamic>> newExchangeRates = [];

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    newExchangeRates = exchangeRates;
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatter finaAmount = MoneyFormatter(
        amount: basedCurrencyConvertion(
                widget.currencyType, widget.productPrice, newExchangeRates)!
            .toDouble());
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Container(
        height: getProportionateScreenHeight(20),
        width: getProportionateScreenWidth(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          padding: const EdgeInsets.all(10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "$imageUrl${widget.productImageUrl}",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(200),
                    child: Text(
                      widget.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: getProportionateScreenWidth(200),
                    child: Row(
                      children: [
                        const Text(
                          'Vendor: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(100),
                          child: Text(
                            widget.vendorName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColor.darkOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        currencySymbolConveeter(widget.currencyType),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        finaAmount.output.nonSymbol,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColor.lightOrange,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Center(
                            child: Text(
                              // orderStatus,
                              orderstatus(widget.orderStatus),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      GestureDetector(
                        onTap: widget.press,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColor.darkOrange,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                        ),
                      )
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
