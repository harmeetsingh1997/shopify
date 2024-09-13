import 'package:shopify/product/model.dart';

abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}


class SendDataEvent extends ProductEvent{
  final Product product;

  SendDataEvent(this.product);
}