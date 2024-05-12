// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/product_detail_screen.dart';
import 'package:bella_banga/src/view/widget/product_grid_view.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/services/product_services.dart';

class ProductByVendorScreen extends StatefulWidget {
  final int vendorId;
  const ProductByVendorScreen({
    super.key,
    required this.vendorId,
  });
  static const String routeName = "/prodcut-by-vendor-id";

  @override
  State<ProductByVendorScreen> createState() => _ProductByVendorScreenState();
}

class _ProductByVendorScreenState extends State<ProductByVendorScreen> {
  List<Product>? product;
  final ProductServices productServices = ProductServices();

  @override
  void initState() {
    super.initState();
    fetchAllProductCategoryById();
  }

  int page = 0;
  int size = 20;

  void fetchAllProductCategoryById() async {
    product = await productServices.fetchAllProductsByVendorId(
        context, widget.vendorId, page, size);
    setState(() {});
  }

  int cartItemsNumber = cartBox.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.lightOrange,
            title: const Text('Shop by vendor',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        body: product == null
            ? const Center(
                child: MyProgressor(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: (product == null) ? 0 : product!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 10 / 16,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return ProductGridView(
                      productImgUrl: "$imageUrl${product![index].thumbnail}",
                      productTitle: product![index].name.toString(),
                      productPrice: product![index].price as double,
                      press: () {
                        Navigator.pushNamed(
                            context, ProductDetailScreen.routeName,
                            arguments: product![index]);
                      },
                      currencyType: product![index].currencyCode.toString(),
                      productId: product![index].id as int,
                    );
                  },
                ),
              ),
        floatingActionButton: Visibility(
          visible: true,
          child: DraggableFab(
            child: Stack(
              children: [
                FloatingActionButton(
                  backgroundColor: AppColor.darkOrange,
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red, // Choose your desired color here
                    ),
                    child: Text(
                      cartItemsNumber.toString(), // Put your badge count here
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
