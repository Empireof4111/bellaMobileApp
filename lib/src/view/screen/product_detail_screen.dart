// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bella_banga/src/view/widget/cart_bottom_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:money_formatter/money_formatter.dart';

import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/model/local_storage_model/addtocartmodel.dart';
import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/product_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/widget/carousel_slider.dart';
import 'package:bella_banga/src/view/widget/page_wrapper.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {super.key});
  static const String routeName = "/Product-detail";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

final ProductServices productServices = ProductServices();
List<Product>? productByCategory;

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    fetchAllFxRate();
    fetchAllProductCategoryById();
  }

  int page = 0;
  int size = 20;

  void fetchAllProductCategoryById() async {
    productByCategory = await productServices.fetchAllProductsByCategory(
        context, widget.product.categoryId as int, page = page, size = size);
    setState(() {});
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    setState(() {
      newExchangeRates = exchangeRates;
    });
  }

  List<Map<String, dynamic>> newExchangeRates = [];

//this custom AppBar
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

//Product image preview sector
  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: CarouselSlider(items: widget.product.images!.split(',')),
    );
  }

//Rating Bar
  Widget _ratingBar(BuildContext context) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar.builder(
          itemSize: 25,
          initialRating: widget.product.ratings ?? 0,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
        ),
        Text(
          "(${widget.product.reviews ?? '0'} Reviews)",
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.w300, fontSize: 18),
        )
      ],
    );
  }

//Product Size sector
  Widget productSizesListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      // itemCount: controller.sizeType(widget.product).length,
      itemBuilder: (_, index) {
        return InkWell(
          // onTap: () => controller.switchBetweenProductSizes(widget.product, index),
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 5, left: 5),
            alignment: Alignment.center,
            // width: controller.isNominal(widget.product) ? 40 : 70,
            decoration: BoxDecoration(
              // color: controller.sizeType(widget.product)[index].isSelected == false
              // ? Colors.white
              // : AppColor.lightOrange,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 0.4),
            ),
            duration: const Duration(milliseconds: 300),
            child: const FittedBox(
              child: Text(
                // controller.sizeType(widget.product)[index].numerical,
                '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String currencyProductCode = currencyChoosed;
  int productQuantity = 1;
  int cartCount() {
    int cartLenth = 0;
    setState(() {
      cartLenth = cartBox.length;
    });
    return cartLenth;
  }

  void increaseQuantity() {
    setState(() {
      productQuantity++;
    });
  }

  void decreaseQuantity() {
    if (productQuantity == 1) {
      1;
    } else {
      setState(() {
        productQuantity--;
      });
    }
  }

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
  }

  bool isBottomSheetVisible = false; // Track the visibility of BottomSheet

  void _showBottomSheet(BuildContext context) {
    // Show BottomSheet
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 1.1,
      ),
      context: context,
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return const CartBottomSheetScreen();
      },
    ).then((value) {
      setState(() {
        isBottomSheetVisible = false;
      });
    });
  }

  int selectedIndex = 0;
  int selectedIndex2 = 0;
  late String cartColor;
  late String cartSize = '0';
  _productColor() {
    return Visibility(
      visible: widget.product.colors!.isEmpty ? false : true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Colors:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            runSpacing: 10,
            direction: Axis.horizontal,
            children: List.generate(widget.product.colors!.split(',').length,
                (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    cartColor =
                        widget.product.colors!.split(',')[selectedIndex];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedIndex == index
                        ? AppColor.darkOrange
                        : AppColor.lightGrey.withOpacity(0.5),
                    border: Border.all(
                        color: selectedIndex == index
                            ? AppColor.darkOrange
                            : Colors.grey),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      cartColor = widget.product.colors!.split(',')[index],
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  _productSize() {
    return Visibility(
      visible: widget.product.sizes!.isEmpty ? false : true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Size:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            runSpacing: 10,
            direction: Axis.horizontal,
            children:
                List.generate(widget.product.sizes!.split(',').length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex2 = index;
                    cartSize = widget.product.sizes!.split(',')[selectedIndex2];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedIndex2 == index
                        ? AppColor.darkOrange
                        : AppColor.lightGrey.withOpacity(0.5),
                    border: Border.all(
                        color: selectedIndex2 == index
                            ? AppColor.darkOrange
                            : Colors.grey),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.product.sizes!.split(',')[index],
                      style: TextStyle(
                          color: selectedIndex2 == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double absAmount = basedCurrencyConvertion(
            widget.product.currencyCode.toString(),
            widget.product.price as double,
            newExchangeRates)!
        .toDouble();
    MoneyFormatter fmf = MoneyFormatter(amount: absAmount);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPageView(width, height),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name.toString(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      _ratingBar(context),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          newExchangeRates.isNotEmpty
                              ? Text(
                                  "${currencySymbolConveeter(currencyChoosed)} ${fmf.output.nonSymbol}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                )
                              : const Text("Loading.."),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: false,
                            child: Text(
                              "${widget.product.currencyCode}${widget.product.price}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RichText(
                          text: TextSpan(
                              text: "Unit: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.red),
                              children: <InlineSpan>[
                            TextSpan(
                                text: widget.product.unit,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ])),
                      const SizedBox(height: 20),
                      _productColor(),
                      const SizedBox(height: 20),
                      _productSize(),
                      const SizedBox(height: 20),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.product.description.toString(),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                        height: 2,
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Reviews:",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(widget.product.reviews ??
                          "No reviews found for this product"),
                      const SizedBox(height: 8),
                      const Divider(
                        height: 2,
                        thickness: 1,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Related Product",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SearchProductCard(
                        productByCategory: productByCategory,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            elevation: 10,
            surfaceTintColor: Colors.white,
            shadowColor: AppColor.lightGrey,
            color: Colors.white,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.remove,
                          color: AppColor.darkOrange,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      productQuantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: increaseQuantity,
                      icon: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.add,
                          color: AppColor.darkOrange,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: Builder(
                      builder: ((context) => DefaultButton(
                          text: "Add to cart",
                          press: () {
                            cartBox.put(
                                "CartBox_key${widget.product.id}",
                                Addtocartmodel(
                                  productName: widget.product.name.toString(),
                                  productColor:
                                      widget.product.colors.toString(),
                                  productSize: cartSize,
                                  productQuantity: productQuantity,
                                  productPrice: widget.product.price as double,
                                  cartImageUrl: widget.product.images!
                                      .split(',')[0]
                                      .toString(),
                                  cartShippingFee:
                                      widget.product.shippingFees as double,
                                  cartServiceCharged:
                                      widget.product.serviceCharge as double,
                                  cartCurrencyCode:
                                      widget.product.currencyCode.toString(),
                                  id: widget.product.id as int,
                                ));
                            _showBottomSheet(context);
                          }))),
                ),
              ],
            )),
      ),
    );
  }
}

class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 40,
        height: 10,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: AppColor.lightGrey.withOpacity(0.5),
        ),
        child: const Center(
            child: Text(
          "black",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
        )),
      ),
    );
  }
}

class SizeCard extends StatelessWidget {
  const SizeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 40,
        height: 10,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: AppColor.lightGrey.withOpacity(0.5),
        ),
        child: const Center(
            child: Text(
          "XL",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
        )),
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchProductCard extends StatefulWidget {
  SearchProductCard({
    super.key,
    required this.productByCategory,
  });

  // final List<Product>? searchProductList;
  List<Product>? productByCategory;

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> {
  List<Map<String, dynamic>> newExchangeRates = [];

  @override
  void initState() {
    fetchAllFxRate();
    super.initState();
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
    return widget.productByCategory == null
        ? const MyProgressor()
        : GridView.builder(
            itemCount: (widget.productByCategory == null)
                ? 0
                : widget.productByCategory!.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 10 / 12,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              double absAmount = basedCurrencyConvertion(
                      widget.productByCategory![index].currencyCode.toString(),
                      widget.productByCategory![index].price as double,
                      newExchangeRates)!
                  .toDouble();
              double discountAmount = absAmount + 5 * (absAmount / 100);
              MoneyFormatter fmf = MoneyFormatter(amount: absAmount);
              MoneyFormatter discountfmf =
                  MoneyFormatter(amount: discountAmount);
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailScreen.routeName,
                      arguments: widget.productByCategory![index]);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 250,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          // border: Border.all(width: 0.5, color: AppColor.lightGrey),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.lightGrey,
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 0.02, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Image.network(
                            fit: BoxFit.fill,
                            scale: 1,
                            "$imageUrl${widget.productByCategory![index].thumbnail.toString()}"),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: AppColor.lightGrey),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.lightGrey,
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 0.02, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productByCategory![index].name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          newExchangeRates.isNotEmpty
                              ? Row(
                                  children: [
                                    Text(
                                        '${currencySymbolConveeter(currencyChoosed)}${fmf.output.nonSymbol}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${currencySymbolConveeter(currencyChoosed)}${discountfmf.output.nonSymbol}',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              : const Text("Loading.."),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
