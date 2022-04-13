import 'package:demo_bloc_marketplace/models/product.dart';
import 'package:demo_bloc_marketplace/modules/product_detail/product_detail_repository.dart';
import 'package:demo_bloc_marketplace/utils/HttpException.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductDetailEvent {}

class GetProductDetailEvent extends ProductDetailEvent {}

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailFailure extends ProductDetailState {
  final String error;
  ProductDetailFailure(this.error);
}

class ProductDetailSuccess extends ProductDetailState {
  final Product product;
  ProductDetailSuccess(this.product);
}

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository repository;
  final String id;
  ProductDetailBloc(this.repository, this.id) : super(ProductDetailInitial()) {
    on<GetProductDetailEvent>(
        (event, emit) => onGetProductDetailEvent(event, emit));
  }
  onGetProductDetailEvent(
      GetProductDetailEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final response = await repository.getProductDetail(id);
      emit(ProductDetailSuccess(response));
    } on HttpException catch (e) {
      emit(ProductDetailFailure(e.toString()));
    }
  }
}
