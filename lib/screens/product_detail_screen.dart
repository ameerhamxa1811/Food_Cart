import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_cart/main.dart';
import 'package:food_cart/screens/product_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product_detail_provider.dart';


class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<ProductDetailProvider>(
        builder: (context, productDetailProvider, _) {
          final productDetail = productDetailProvider.productDetail;
          return SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: screenHeight * 380 / 812.h,
                      width: screenWidth,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/italian_food.png',
                            fit: BoxFit.cover,
                            height: 380.h,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w, top: 75.h, right: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: screenHeight * 40 / 812.h,
                                  width: screenWidth * 40 / 375.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(25.sp),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back, color: Color(0xff2D264B)),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen()),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: screenHeight * 40 / 812.h,
                                  width: screenWidth * 40 / 375.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(25.sp),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Color(0xff1E1E1E),
                                    ),
                                    onPressed: () {
                                      // Handle favorite action
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 80.h,
                            left: MediaQuery.of(context).size.width / 2 - 30.w,
                            child: Row(
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  margin: EdgeInsets.symmetric(horizontal: 4.sp),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  margin: EdgeInsets.symmetric(horizontal: 4.sp),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  margin: EdgeInsets.symmetric(horizontal: 4.sp),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.5), // Spacer for the bottom container
                  ],
                ),
                Positioned(
                  top: screenHeight * 0.42, // Adjust to overlap the top container
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.65,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: Container(
                        height: screenHeight * 336/812.h,
                        width: screenWidth * 325/375.w,
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetail.name,
                              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      color: index < productDetail.rating.floor()
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(productDetail.rating.toString()),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16.sp),
                                    SizedBox(width: 4.w),
                                    Text(productDetail.time),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(productDetail.description),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price\nRs ${productDetail.price}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle "Pay Now" action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                  child: Text(
                                    'Pay Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
