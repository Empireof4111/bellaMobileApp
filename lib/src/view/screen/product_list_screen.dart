// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/model/vendorModel.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/product_by_vendor_screen.dart';
import 'package:bella_banga/src/view/screen/product_detail_screen.dart';
import 'package:bella_banga/src/view/screen/search_result_screen.dart';
import 'package:bella_banga/src/view/screen/vendor_screen.dart';
import 'package:bella_banga/src/view/widget/product_grid_view.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/app_data.dart';
import 'package:bella_banga/src/model/categoryModel.dart';
import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/services/product_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/category_screen.dart';
import 'package:bella_banga/src/view/screen/product_by_category_screen.dart';

// final Product product = Product();

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<CategoryModel>? categories;
  List<Product>? product;
  List<VendorModel>? vendorList;
  List<Map<String, dynamic>> newExchangeRates = [];

  final ProductServices productServices = ProductServices();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchAllProductCategory();
    fetchAllProdut();
    fetchAllVendors();
    fetchAllFxRate();
  }

  Future<void> fetchAllFxRate() async {
    List<Map<String, dynamic>> exchangeRates =
        await CurrencyConversionApi.getExchangeRates();
    newExchangeRates = exchangeRates;
  }

  void fetchAllProductCategory() async {
    categories = await productServices.fetchAllCategory(context);
    // setState(() {
    // });
  }

  void fetchAllProdut() async {
    product = await productServices.fetchAllUserProducts(context, 0, 20);
    setState(() {});
  }

  void fetchAllVendors() async {
    vendorList = await authService.fetchAllVendors(context, 0, 20);
    setState(() {});
  }

  bool isVisible = true;
  // showFloatongButton() {
  //   if (cartItemsNumber == 0) {
  //     setState(() {
  //       isVisible = false;
  //     });
  //   } else {
  //     setState(() {
  //       isVisible = true;
  //     });
  //   }
  // }

  // int cartItemsNumber = cartBox.length;
  int cartItemsNumber = 0;
  int cartCountFunc() {
    setState(() {
      cartItemsNumber = cartBox.length;
    });
    return cartItemsNumber;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            height: 100,
            color: AppColor.lightOrange,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo002.png',
                          height: 50,
                        ),
                        const Text(
                          "Bella Banga",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          dropdownColor: AppColor.lightOrange,
                          iconEnabledColor: Colors.white,
                          underline: const SizedBox(),
                          value: currencyChoosed,
                          onChanged: (newValue) {
                            setState(() {
                              currencyChoosed = newValue.toString();
                            });
                          },
                          items: currencyList.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onSearchIconPressed(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Search..'), Icon(Icons.search)],
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  _recommendedProductListView(context),
                  const SizedBox(
                    height: 10,
                  ),
                  HeaderTitle(
                      seeAll: "SEE ALL",
                      title: "Shop by vendors",
                      press: () {
                        Navigator.pushNamed(context, VendorScreen.routeName);
                      }),
                  vendorList == null
                      ? const Center(
                          child: MyProgressor(),
                        )
                      : Container(
                          height: 50,
                          color: Colors.transparent,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                (vendorList == null) ? 0 : vendorList!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(8)),
                                  child: Container(
                                    height: 80,
                                    width: 200, //main box
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //     width: 1,
                                      //     color: AppColor.lightOrange
                                      //         .withOpacity(0.2)
                                      //         ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 30,
                                              width: 30,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.black,
                                              ),
                                              child: Image.network(
                                                imageUrl +
                                                    vendorList![index]
                                                        .dpLink
                                                        .toString(),
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/logo002.png',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      getProportionateScreenWidth(
                                                          120),
                                                  child: Text(
                                                      vendorList![index]
                                                          .businessName
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProductByVendorScreen.routeName,
                                      arguments: vendorList![index].id);
                                },
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  HeaderTitle(
                      seeAll: "SEE ALL",
                      title: "Top categories",
                      press: () {
                        Navigator.pushNamed(context, CategoryScreen.routName);
                      }),
                  //TOP CATEGORY
                  categories == null
                      ? const Center(
                          child: MyProgressor(),
                        )
                      : Container(
                          height: 80,
                          color: Colors.transparent,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                (categories == null) ? 0 : categories!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return TopCategoryCard(
                                categoryName: categories![index]
                                    .category!
                                    .name
                                    .toString(),
                                categoryImage:
                                    "$imageUrl${categories![index].category?.imageLink}",
                                press: () {
                                  Navigator.pushNamed(context,
                                      ProductByCategoryScreen.routeName,
                                      arguments:
                                          categories?[index].category!.id);
                                },
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 2.0,
                                    crossAxisCount: 1,
                                    childAspectRatio: 1),
                          )),

                  //POPULAR PRODUCT SECTION
                  const SizedBox(
                    height: 10,
                  ),
                  const HeaderTitle2(title: "Popular product"),

                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: product == null
                        ? const Center(
                            child: MyProgressor(),
                          )
                        : GridView.builder(
                            itemCount: (product == null) ? 0 : product!.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 10 / 16,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (_, index) {
                              return ProductGridView(
                                productImgUrl:
                                    "$imageUrl${product![index].thumbnail}",
                                productTitle: product![index].name.toString(),
                                productPrice: product![index].price as double,
                                press: () {
                                  Navigator.pushNamed(
                                      context, ProductDetailScreen.routeName,
                                      arguments: product![index]);
                                },
                                currencyType:
                                    product![index].currencyCode.toString(),
                                productId: product![index].id as int,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: isVisible,
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
                      cartCountFunc().toString(),
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

void _onSearchIconPressed(BuildContext context) async {
  showSearch(
    context: context,
    delegate: SearchBarDelegate(),
  );
}

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return Center(
        child: SearchResultScreen(
      query: query,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here
    return const Center(child: Text('Search Product'));
  }
}

//slider
Widget _recommendedProductListView(BuildContext context) {
  return SizedBox(
    height: 170,
    child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: AppData.recommendedProducts.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 320,
              decoration: BoxDecoration(
                color: AppColor.darkOrange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to\n BELLA BANGA',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppData.recommendedProducts[index]
                                .buttonBackgroundColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            "Get Now",
                            style: TextStyle(
                              color: AppData
                                  .recommendedProducts[index].buttonTextColor!,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/shopping.png',
                    height: 125,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          );
        }),
  );
}

class HeaderTitle extends StatelessWidget {
  final String title, seeAll;
  final GestureTapCallback press;
  const HeaderTitle(
      {super.key,
      required this.seeAll,
      required this.title,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: press,
            style: TextButton.styleFrom(foregroundColor: AppColor.darkOrange),
            child: Text(
              seeAll,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColor.darkOrange),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderTitle2 extends StatelessWidget {
  final String title;
  const HeaderTitle2({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }
}

class TopCategoryCard extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  final GestureTapCallback press;
  const TopCategoryCard({
    super.key,
    required this.categoryImage,
    required this.categoryName,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.network(
                  categoryImage,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset("assets/images/errorImage.png");
                  },
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10,),
          SizedBox(
            width: 60,
            child: Text(
              categoryName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
