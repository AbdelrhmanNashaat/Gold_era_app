import '../../../../home/data/models/item_model.dart';

abstract class GetGoldIngotsState {}

class GetGoldIngotsInitial extends GetGoldIngotsState {}

class GetGoldIngotsLoading extends GetGoldIngotsState {}

class GetGoldIngotsLoaded extends GetGoldIngotsState {
  final List<Product> products;
  GetGoldIngotsLoaded(this.products);
}

final class GetGoldIngotsError extends GetGoldIngotsState {
  final String message;
  GetGoldIngotsError(this.message);
}
