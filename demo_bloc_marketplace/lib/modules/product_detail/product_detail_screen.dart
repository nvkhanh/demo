import 'package:demo_bloc_marketplace/models/product.dart';
import 'package:demo_bloc_marketplace/modules/product_detail/product_detail_bloc.dart';
import 'package:demo_bloc_marketplace/modules/product_detail/product_detail_repository.dart';
import 'package:demo_bloc_marketplace/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  final repository = ProductDetailRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(repository, product.id.toString()),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag))],
        ),
        body:  buildProductDetail(product: product),
      ),
    );
  }
}

class buildProductDetail extends StatefulWidget {
   Product product;
   buildProductDetail({Key? key,required this.product}) : super(key: key);

  @override
  State<buildProductDetail> createState() => _buildProductDetailState();
}

class _buildProductDetailState extends State<buildProductDetail> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductDetailBloc>(context).add(GetProductDetailEvent());
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state is ProductDetailSuccess) {
        widget.product = state.product;
      }
      return _buildWidgetProductDetail(widget.product, context);
    }, listener: (context, state) {
      if (state is ProductDetailFailure) {
        Utils.showDefaultDialog(
            context, const Text("Error"), Text(state.error));
      }
    });
  }
}

Widget _buildWidgetProductDetail(Product product, BuildContext context) {
  return Column(
    children: [
      Container(
        height: MediaQuery.of(context).size.height * .35,
        padding: const EdgeInsets.only(bottom: 30),
        width: double.infinity,
        child: Image.network(product.image),
      ),
      Expanded(
          child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Container(
              height: MediaQuery.of(context).size.height * .65,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rate),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        product.rating.rate.toString(),
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '\$' + product.price.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),

                ],
              ),
            ),
          )
        ],
      ))
    ],
  );
}
