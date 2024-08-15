import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/home/bloc/home_bloc.dart';
import 'package:new_shop/product/bloc/product_bloc.dart';
import 'package:new_shop/product/view/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //add event to product bloc
    context.read<ProductBloc>().add(SystemLoadProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is HomeLogoutSuccess) {
              //navigate to login and remove all previous routes
              Navigator.of(context).pop('/');
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, productState) {
                  if (productState is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (productState is ProductLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productState.products.length,
                        itemBuilder: (context, index) {
                          final product = productState.products[index];
                          return ProductItem(product: product);
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                }),
                //add product list
                //add logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //add event to home bloc
                      context.read<HomeBloc>().add(UserTapLogoutButton());
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //add event to home bloc
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
