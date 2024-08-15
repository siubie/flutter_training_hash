import 'package:flutter/material.dart';
import 'package:new_shop/product/response/product_success_response.dart';

class ProductItem extends StatelessWidget {
  final ProductSuccessResponse product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //add product image
            Image.network(
              product.images![0],
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Text(
              product.title!,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
