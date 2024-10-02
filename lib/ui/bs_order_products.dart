
import 'package:flutter/material.dart';
import 'package:vendor/common/widgets/order.dart';
import 'package:vendor/model/order.dart';

Future orderProductsBS({context, required Order order}) {
  return showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    sheetAnimationStyle: AnimationStyle(),
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.products?.length ?? 0,
            itemBuilder: (context, index) =>
                rowOrderProduct(order.products![index]),
          )
        ],
      ),
    ),
  );
}
