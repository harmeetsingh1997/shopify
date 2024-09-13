import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopify/product/product_bloc/product_event.dart';
import 'package:shopify/product/product_bloc/product_state.dart';
import 'package:shopify/product/product_data_source.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDataSource productDataSource;

  ProductBloc(this.productDataSource) : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SendDataEvent>(_sendData);
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit,) async {
    emit(ProductLoading());
    try {
      final products = await productDataSource.fetchData();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to fetch products: ${e.toString()}'));
    }
  }

  Future<void> _sendData(SendDataEvent event,Emitter<ProductState> emit)async{
    try{
      await productDataSource.storeData(event.product);
      emit(ProductAdded());
    }
        catch(e){
      emit(ProductError(e.toString()));
        }
  }
}
