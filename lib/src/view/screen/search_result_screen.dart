// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/services/currency_converter_services.dart';
import 'package:bella_banga/src/services/product_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/product_detail_screen.dart';
import 'package:money_formatter/money_formatter.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({
    super.key,
    required this.query,
  });

  

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}




class _SearchResultScreenState extends State<SearchResultScreen> {
 List<Product>? searchProductList;

 final ProductServices productServices = ProductServices();

 @override
 void initState() {
    searchedProduct();
    fetchAllFxRate();
    super.initState();
  }

  Future<void> fetchAllFxRate() async{
    List<Map<String, dynamic>> exchangeRates = await CurrencyConversionApi.getExchangeRates();
    setState(() {
    newExchangeRates = exchangeRates;
    });
  }


 void searchedProduct () async {
    searchProductList = await productServices.searchProducts(context, 0, 20, widget.query);
  setState(() {
  });
  }
  @override
  Widget build(BuildContext context) {

    if(searchProductList == null){
            return const Center(child: MyProgressor());
    }else if(searchProductList!.isEmpty){
            return const Center(child: Text('Product Not Found'));
    }else{
     return Scaffold(
      body:
      SearchProductCard(searchProductList: searchProductList),
    
    );
    }
   
  }
}

class SearchProductCard extends StatefulWidget { 
  const SearchProductCard({
    super.key,
    required this.searchProductList,
  });

  final List<Product>? searchProductList;
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

  Future<void> fetchAllFxRate() async{
    List<Map<String, dynamic>> exchangeRates = await CurrencyConversionApi.getExchangeRates();
    setState(() {
    newExchangeRates = exchangeRates;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.searchProductList == null ? const MyProgressor() : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: GridView.builder(
      itemCount: (widget.searchProductList == null)? 0 : widget.searchProductList!.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 10 / 12,
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
         double absAmount =  basedCurrencyConvertion(widget.searchProductList![index].currencyCode.toString(), widget.searchProductList![index].price as double, newExchangeRates)!.toDouble();
        double discountAmount = absAmount+5*(absAmount/100);
        MoneyFormatter fmf = MoneyFormatter(amount: absAmount);
        MoneyFormatter discountfmf = MoneyFormatter(amount: discountAmount);
         return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: widget.searchProductList![index]);
            },
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 150,
                  width: 200,
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                child: Image.network(fit: BoxFit.fill, scale: 1, "$imageUrl${widget.searchProductList![index].thumbnail.toString()}" ),
                 ),
                  
              Container(
                width: 200,
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                 padding: const EdgeInsets.symmetric(horizontal: 4),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(widget.searchProductList![index].name.toString(), 
                        style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      
                newExchangeRates.isNotEmpty ?  Row(
                   children: [
                   Text('${currencySymbolConveeter(currencyChoosed)}${fmf.output.nonSymbol}', 
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                    const SizedBox(width: 10,),
                     Text('${currencySymbolConveeter(currencyChoosed)}${discountfmf.output.nonSymbol}',
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
                 )  : const Text("Loading.."),
              
                     ],
                   ),
                 ),


              ],
            ),
          );
        },
      
      ),
    );
  }
}
