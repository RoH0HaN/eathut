import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/texts.dart';
import 'package:eathut/screens/authentication/controllers/add_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../utils/validation.dart';
import '../../../../widgets/button_loading_widget.dart';
import '../../../../widgets/custom_text_field.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAddressController controller = Get.put(AddAddressController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton.filled(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              grey.withOpacity(0.3),
            ), // Set the desired fill color
          ),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Text(
          'Add new address',
          style: GoogleFonts.rubik(fontSize: 50.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  AppTexts.addAddressSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: grey,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 50.h),
                CustomTextField(
                  hintText: "John Doe",
                  labelText: "FULL NAME",
                  prefixIcon: Icons.person_2_outlined,
                  validator: validateString,
                  textEditingController: controller.fullNameCon,
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  hintText: "3235 Royal Ln. mesa, new jersy 34567",
                  labelText: "ADDRESS",
                  prefixIcon: Icons.map_rounded,
                  validator: validateString,
                  textEditingController: controller.addressCon,
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Islampur",
                        labelText: "CITY",
                        prefixIcon: Icons.location_city,
                        validator: validateString,
                        textEditingController: controller.cityCon,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: CustomTextField(
                        hintText: "7411**",
                        labelText: "ZIP CODE",
                        prefixIcon: Icons.pin,
                        validator: validatePostalCode,
                        textEditingController: controller.pinCodeCon,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  hintText: "eg: Near ABC Store",
                  labelText: "LANDMARK",
                  prefixIcon: Icons.location_on_outlined,
                  validator: validateString,
                  textEditingController: controller.landmarkCon,
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  hintText: "1234567890",
                  labelText: "PHONE",
                  prefixIcon: Icons.call,
                  validator: validatePhoneNumber,
                  textEditingController: controller.phoneCon,
                ),
                SizedBox(height: 40.h),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 150.h,
                    child: ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? () {}
                          : () {
                              if (formKey.currentState!.validate()) {
                                controller.addAddress(context);
                              }
                            },
                      label: controller.isLoading.value
                          ? const ButtonLoadingWidget()
                          : Text(
                              AppTexts.saveAddress,
                              style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      icon: controller.isLoading.value
                          ? const SizedBox()
                          : const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
