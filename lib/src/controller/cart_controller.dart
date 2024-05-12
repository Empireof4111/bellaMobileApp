import 'package:get/get.dart';

class CartController extends GetxController{
  int cartCount = 1;
  void increaseCart(){
    cartCount++;
  }

  void decreaseCount(){
    if(cartCount > 1){
      cartCount--;
    }

  }
}