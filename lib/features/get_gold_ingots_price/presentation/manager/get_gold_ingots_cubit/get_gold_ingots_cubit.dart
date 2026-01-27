import '../../../../../utils/services/api_service.dart';
import 'get_gold_ingots_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetGoldIngotsCubit extends Cubit<GetGoldIngotsState> {
  GetGoldIngotsCubit() : super(GetGoldIngotsInitial());
  final ApiService apiService = ApiService();
  Future<void> fetchGoldIngotsPrice() async {
    try {
      emit(GetGoldIngotsLoading());
      final products = await apiService.getGoldIngotProducts();
      emit(GetGoldIngotsLoaded(products));
    } catch (e) {
      emit(GetGoldIngotsError(e.toString()));
    }
  }
}
