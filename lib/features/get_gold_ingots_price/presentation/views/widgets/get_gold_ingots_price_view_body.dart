import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../home/data/models/item_model.dart';
import '../../manager/get_gold_ingots_cubit/get_gold_ingots_cubit.dart';
import '../../manager/get_gold_ingots_cubit/get_gold_ingots_state.dart';
import 'gold_ingots_item.dart';

class GetGoldIngotsPriceViewBody extends StatefulWidget {
  const GetGoldIngotsPriceViewBody({super.key});

  @override
  State<GetGoldIngotsPriceViewBody> createState() =>
      _GetGoldIngotsPriceViewBodyState();
}

class _GetGoldIngotsPriceViewBodyState
    extends State<GetGoldIngotsPriceViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<GetGoldIngotsCubit>().fetchGoldIngotsPrice();
  }

  List<Product> products = [];

  final List<Product> fakeProducts = List.generate(
    8,
    (_) => Product.placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetGoldIngotsCubit, GetGoldIngotsState>(
      listener: (context, state) {
        if (state is GetGoldIngotsLoaded) {
          products = state.products;
        }
      },
      builder: (context, state) {
        final bool isLoading = state is GetGoldIngotsLoading;

        final List<Product> displayProducts = isLoading
            ? fakeProducts
            : products;

        if (state is GetGoldIngotsError) {
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Skeletonizer(
          enabled: isLoading,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList.builder(
                itemCount: displayProducts.length,
                itemBuilder: (context, index) {
                  final product = displayProducts[index];
                  return GoldIngotsItem(product: product);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
