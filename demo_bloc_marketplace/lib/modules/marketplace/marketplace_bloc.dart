import 'package:demo_bloc_marketplace/models/product.dart';
import 'package:demo_bloc_marketplace/modules/marketplace/marketplace_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/HttpException.dart';

abstract class MarketplaceEvent {}

class GetProductListEvent extends MarketplaceEvent {}

abstract class MarketplaceState {}

class MarketplaceInitial extends MarketplaceState {}

class MarketplaceLoading extends MarketplaceState {}

class MarketplaceFailure extends MarketplaceState {
  final String error;

  MarketplaceFailure(this.error);
}

class MarketplaceSuccess extends MarketplaceState {
  final List<Product> productList;

  MarketplaceSuccess(this.productList);
}

class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final MarketplaceRepository repository;

  MarketplaceBloc(this.repository) : super(MarketplaceInitial()) {
    on<GetProductListEvent>(
        (event, emit) => onGetProductListEvent(event, emit));
  }

  onGetProductListEvent(
      GetProductListEvent event, Emitter<MarketplaceState> emit) async {
    emit(MarketplaceLoading());
    try {
      final response = await repository.getProductList();
      emit(MarketplaceSuccess(response));
    } on HttpException catch (e) {
      emit(MarketplaceFailure(e.toString()));
    }
  }
}
