import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import 'package:shopify/product/model.dart';

class ProductDataSource{

Future<List<Product>>  fetchData()async {
  Uri url = Uri.parse('https://fakestoreapi.com/products');
  final response = await http.get(url);
  if(response.statusCode==200){
    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json)=>Product.fromJson(json)).toList();

  }
  else{
    throw Exception('failed to fetch data');
  }
}


Future<void>  storeData(Product product)async{
   await FirebaseFirestore.instance.collection('products').add({
    'title':product.title,
    'price':product.price,
    'image':product.image,
    'description':product.description,
  });

}

}