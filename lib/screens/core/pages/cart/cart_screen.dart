import 'package:eathut/constants/colors.dart';
import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/screens/core/hooks/fetch_all_cart_products.dart';
import 'package:eathut/screens/core/models/cart_model.dart';
import 'package:eathut/screens/core/pages/cart/widgets/cart_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Using Cart Hook
    final cartHookResult = useFetchAllCartProducts();
    List<CartModel>? cartProducts = cartHookResult.data;
    bool isLoading = cartHookResult.isLoading;
    final userAddress = AuthenticationRepository.instance.address;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        surfaceTintColor: black,
        leading: IconButton.filled(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              grey.withOpacity(0.3),
            ), // Set the desired fill color
          ),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            LineAwesomeIcons.angle_left_solid,
            color: white,
          ),
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.rubik(fontSize: 50.sp, color: white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: white,
            ))
          : ListView.separated(
              itemBuilder: (context, index) {
                CartModel cartProduct = cartProducts![index];
                return CartProductTile(cartProduct: cartProduct);
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemCount: cartProducts?.length ?? 0,
            ),
      bottomNavigationBar: isLoading
          ? null
          : Container(
              // height: 750.h,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery address (Your default address)',
                        style: GoogleFonts.poppins(
                          fontSize: 40.sp,
                          color: grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            fontSize: 40.sp,
                            color: baseColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    // height: 200.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                      color: baseColorBlended,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userAddress?.fullName ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 40.sp,
                            color: baseColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${userAddress?.city ?? ''} | ${userAddress?.zipCode ?? ''}",
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userAddress?.address ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userAddress?.landmark ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Total amount',
                    style: GoogleFonts.poppins(
                      fontSize: 40.sp,
                      color: grey,
                    ),
                  ),
                  Text(
                    "₹${cartProducts?.fold<num>(0, (sum, cartProduct) => sum + (cartProduct.productId?.price?.discountPrice ?? 0) * (cartProduct.quantity ?? 0)) ?? 0}",
                    style: GoogleFonts.montserrat(
                      fontSize: 70.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Add to cart",
                        style: GoogleFonts.poppins(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
