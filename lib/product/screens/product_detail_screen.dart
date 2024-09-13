import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/product/model.dart';
import 'package:shopify/product/product_bloc/product_bloc.dart';
import 'package:shopify/product/product_bloc/product_event.dart';
import 'package:shopify/product/product_bloc/product_state.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          context.read<ProductBloc>().add(SendDataEvent(product));
        },
        child: const Icon(Icons.upload_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product uploaded successfully!')),
              );
            } else if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: ListView(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.3,
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description ?? 'No description available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
