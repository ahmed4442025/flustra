// lib/widgets/category_list_widget.dart
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  final bool loading;

  final List<String>? categories;

  const CategoryListWidget({super.key, required this.loading, this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: loading ? 10 : categories?.length ?? 0,
            itemBuilder: (context, index) {
              if (loading) return ShimmerHelper.buildBasicShimmer(height: 40, width: 100, radios: 8);
              return Chip(
                label: Text(categories?[index] ?? ""),
                backgroundColor: Colors.teal.withOpacityEX(0.1),
                side: BorderSide(color: Colors.teal.withOpacityEX(0.5)),
                labelStyle: TextStyle(
                  color: Colors.teal[800],
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }, separatorBuilder: (BuildContext context, int index)=> const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
