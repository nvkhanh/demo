import 'dart:convert';

import 'package:demo_bloc_marketplace/models/product.dart';
import 'package:demo_bloc_marketplace/utils/HttpException.dart';
import 'package:demo_bloc_marketplace/utils/api.dart';
import 'package:demo_bloc_marketplace/shared/base_repository.dart';

class MarketplaceRepository extends BaseRepository {
  MarketplaceRepository();

  Future<List<Product>> getProductList() async {
    final response = await client
        .get(Uri.parse(ApiConstant.BASE_URL + ApiConstant.GET_PRODUCT_LIST));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((product) => Product.fromJson(product))
          .toList();
    }
    throw HttpException("An error occurred while connecting to server");
  }
}
