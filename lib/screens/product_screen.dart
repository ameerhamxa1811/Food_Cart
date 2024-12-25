import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_cart/main.dart';
import 'package:food_cart/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Container(
              height: screenHeight * 32/812.h,
              width: screenWidth * 151/375.w,
              // color: Colors.green,
              child: Center(
                child: Text(
                  'Hi Username!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w700,
                    height: 32 / 22, // Line height calculation
                    letterSpacing: 0.5.sp,
                    color: Color(0xff2E3E5C),
                  ),
                ),
              ),
          ),
          ),
              SizedBox(height: screenHeight * 24/812.h),
              Container(
                height: screenHeight * 24/812.h,
                width: screenWidth * 104/375.w,
                // color: Colors.green,
                child: Center(
                  child: Text(
                    'Popular Now',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                      height: 24 / 22, // Line height calculation
                      letterSpacing: 0.5.sp,
                      color: Color(0xff2E3E5C),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 8/812.h),
              Expanded(
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.sp,
                        mainAxisSpacing: 2.sp,
                        childAspectRatio: 0.78.sp,
                      ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ProductDetailScreen and pass the product as an argument
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(),
                              ),
                            );
                          },
                          child: Card(
                            color: Color(0xffF1F6FB),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: Image.asset(
                                        'assets/images/burger.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(product.name,
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 20 / 14, // Line height calculation
                                        letterSpacing: 0.2.sp,
                                        color: Color(0xff1E3354),
                                      )),
                                  Text(product.location,
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 14.52 / 12, // Line height calculation
                                        letterSpacing: 0.2.sp,
                                        color: Color(0xff7F8E9D),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs ${product.price}',
                                        style: TextStyle(
                                          color: Color(0xffFCC050),
                                          fontFamily: 'Inter',
                                          fontSize: 20.0.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 24.2 / 20, // Line height calculation
                                          letterSpacing: 0.2.sp,
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 37 / 812.h,
                                        width: screenWidth * 37 / 375.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(36.sp),
                                          color: Color(0xffFCC050),
                                        ),
                                        child: Image.asset(
                                          'assets/images/shopping_bag.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
