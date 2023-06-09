import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../../domain/entities/cart_items.dart';
import 'decrease_product_button.dart';
import 'delete_product_from_cart.dart';
import 'increase_product_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartItems cartItems;
  final int quantity;
  final int uniqueId;

  const CartItemWidget({
    required this.cartItems,
    required this.quantity,
    required this.uniqueId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = cartItems.productItem!;
    bool isDark = ThemeAndLanguageCubit.object(context).theme == ThemeMode.dark;
    TextTheme textContext = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Card(
        child: SizedBox(
          height: height * 0.18,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  placeholder: (ctx, s) =>
                      Image.asset('assets/images/loading.gif'),
                  errorWidget: (ctx, s, _) =>
                      Image.asset('assets/images/imageError.png'),
                  width: width * 0.3,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 5.w,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.35,
                        width: width * 0.55,
                        child: Text(
                          product.name,
                          style: textContext.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.3,
                        width: width * 0.55,
                        child: Row(
                          children: [
                            DecreaseProductButton(
                              quantity: quantity,
                              uniqueId: uniqueId,
                            ),
                            IncreaseProductButton(
                              quantity: quantity,
                              uniqueId: uniqueId,
                            ),
                            const Spacer(),
                            DeleteProductFromCart(
                              productId: product.id,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: width * 0.55,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Chip(
                              label: Text(
                                '${product.price.toInt()} ${'eg'.translate(context)}',
                                style: textContext.bodyMedium,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (product.discount != 0)
                              Text(
                                '${product.oldPrice.toInt()}',
                                style: textContext.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            const Spacer(),
                            RichText(
                              text: TextSpan(
                                  text: quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        isDark ? Colors.white : Colors.blueGrey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' X',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.blueGrey,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
