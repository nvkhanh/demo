import 'package:demo_bloc_marketplace/utils/HttpException.dart';
import 'dart:convert';

import 'package:demo_bloc_marketplace/models/product.dart';
import 'package:demo_bloc_marketplace/shared/base_repository.dart';
import 'package:demo_bloc_marketplace/utils/api.dart';

class ProductDetailRepository extends BaseRepository {
  ProductDetailRepository();

  Future<Product> getProductDetail(String id) async {
    final response = await client.get(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.GET_PRODUCT_LIST + id));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    }
    throw HttpException("An error occurred while connecting to server");
  }
}
