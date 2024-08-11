import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/screens/core/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CartProductTile extends StatelessWidget {
  const CartProductTile({super.key, required this.cartProduct});

  final CartModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.0001),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 350.h,
                width: 350.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(cartProduct.productId?.imageUrl ??
                        AppImages.demoImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartProduct.productId?.foodName ?? 'Food',
                              style: GoogleFonts.poppins(
                                fontSize: 50.sp,
                                color: white,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              '₹${cartProduct.productId?.price?.discountPrice ?? 0}',
                              style: GoogleFonts.montserrat(
                                fontSize: 50.sp,
                                color: white,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                    ),
                    IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ), // Set the desired fill color
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        LineAwesomeIcons.trash_alt,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.h,
          right: 20.w,
          child: Container(
            height: 150.h,
            width: 400.w,
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        grey), // Set the desired fill color
                  ),
                  onPressed: () {},
                  icon: const Icon(LineAwesomeIcons.minus_solid),
                ),
                Text(
                  "${cartProduct.quantity}",
                  style: GoogleFonts.poppins(
                    fontSize: 50.sp,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        grey), // Set the desired fill color
                  ),
                  onPressed: () {},
                  icon: const Icon(LineAwesomeIcons.plus_solid),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
