// ignore: file_names
import 'package:hive/hive.dart';

part 'addtocartmodel.g.dart';

@HiveType(typeId: 1)
class Addtocartmodel {

  Addtocartmodel({
    required this.id,
    required this. cartCurrencyCode, 
    required this.cartServiceCharged, 
    required this.cartShippingFee, 
    required this.cartImageUrl, 
    required this.productName, 
    required this.productColor, 
    required this.productSize, 
    required this.productQuantity, 
    required this.productPrice });

  @HiveField(0)
  String productName;

  @HiveField(1)
  String productColor;

  @HiveField(2)
  String productSize;

  @HiveField(3)
  int productQuantity;

  @HiveField(4)
  double productPrice;

  @HiveField(5)
  String cartImageUrl;

  @HiveField(6)
  double cartShippingFee;

  @HiveField(7)
  double cartServiceCharged;

  @HiveField(8)
  String cartCurrencyCode;

  @HiveField(9)
  int id;
}
