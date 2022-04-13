import 'package:demo_bloc_marketplace/modules/marketplace/marketplace_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../../utils/utils.dart';
import 'marketplace_bloc.dart';
import 'widgets/product_tile.dart';

class MarketplaceScreen extends StatelessWidget {
  MarketplaceScreen({Key? key}) : super(key: key);
  final apiRepository = MarketplaceRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarketplaceBloc(apiRepository),
      child: const MarketplaceView(),
    );
  }
}

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({Key? key}) : super(key: key);

  @override
  State<MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<MarketplaceView> {
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MarketplaceBloc>(context).add(GetProductListEvent());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listener: (context, state) {
          if (state is MarketplaceFailure) {
            Utils.showDefaultDialog(
                context, const Text("Error"), Text(state.error));
          }
        },
        builder: (context, state) {
          List<Product> productList = [];
          if (state is MarketplaceSuccess) {
            productList = state.productList;
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is MarketplaceSuccess)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          _buildProductList(productList),
                        ],
                      ),
                  ],
                ),
              ),
              state is MarketplaceLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductList(List<Product> productList) => GridView.count(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 22,
        ),
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: productList
            .map((product) => ProductTile(
                  name: product.title,
                  price: product.price,
                  imgUrl: product.image,
                  imgHeight: height / 8,
                  onItemClicked: () {},
                ))
            .toList(),
      );
}
