// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/src/model/vendorModel.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/product_by_vendor_screen.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/core/app_color.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({
    super.key,
  });
  static const String routeName = "/vendor-screen";

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final AuthService authService = AuthService();
  List<VendorModel>? vendorList;

  @override
  void initState() {
    super.initState();
    fetchAllVendors();
  }

  void fetchAllVendors() async {
    vendorList = await authService.fetchAllVendors(context, 0, 20);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //   if(vendorList == null){
    //         return const Center(child: MyProgressor());
    // }else if(vendorList!.isEmpty){
    //         return const Center(child: Text('Product Not Found'));
    // }else{
    int cartItemsNumber = cartBox.length;
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.lightOrange,
            title: const Text('Vendors',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        body: vendorList == null
            ? const Center(child: MyProgressor())
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  itemCount: (vendorList == null) ? 0 : vendorList!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return VendorShopCard(
                      shopName: vendorList![index].businessName.toString(),
                      vendorName: vendorList![index].name.toString(),
                      vendorAddress:
                          vendorList![index].businessAddress.toString(),
                      press: () {
                        Navigator.pushNamed(
                            context, ProductByVendorScreen.routeName,
                            arguments: vendorList![index].id);
                      },
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
                  backgroundColor: AppColor.lightOrange,
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

class VendorShopCard extends StatelessWidget {
  final String shopName;
  final String vendorName;
  final String vendorAddress;
  final GestureTapCallback press;
  const VendorShopCard({
    super.key,
    required this.shopName,
    required this.vendorName,
    required this.vendorAddress,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: press,
            child: Container(
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
                            Icons.shopping_cart,
                            color: AppColor.darkOrange,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          vendorName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      shopName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      vendorAddress,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
