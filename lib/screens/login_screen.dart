import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_cart/screens/product_screen.dart';
import 'package:provider/provider.dart';
import '../firebase_auth_services/login_auth.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  final LoginAuth _authService = LoginAuth(); // Instance of LoginAuth

  void _login() async {
    final String? result = await _authService.loginWithEmailAndPassword( // Use the instance
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _message = result ?? 'Unexpected error occurred.';
    });

    if (_message.contains('Login successful')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProductScreen()),
      );
    } else {
      // Show snackbar for errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 134.h,
              ),
              Container(
                height: screenHeight * 40/812.h,
                width: screenWidth * 243/375.w,
                // color: Colors.amberAccent,
                child: Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      height: 40.32 / 32,
                      textBaseline: TextBaseline.alphabetic,
                      decorationColor: Color(0xFF101828),
                      decorationThickness: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xff435A39),
                        fontFamily: 'PlusJakartaSans-Regular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 17.64 / 14,
                      ),// Added label text
                      hintText: 'user@mail.com',
                      hintStyle: TextStyle(
                        color: Color(0xff171717),
                        fontFamily: 'PlusJakartaSans-Regular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 20.16 / 16,
                      ),
                      contentPadding: EdgeInsets.only(left: 16.0.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.sp),
                        borderSide: BorderSide(
                          color: Color(0xff435A39),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.sp),
                        borderSide: BorderSide(
                          color: Color(0xff435A39),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color(0xff435A39),
                        fontFamily: 'PlusJakartaSans-Regular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 17.64 / 14,
                      ),// Added label text
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color(0xff171717),
                        fontFamily: 'PlusJakartaSans-Regular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 20.16 / 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                        },
                      ),
                      contentPadding: EdgeInsets.only(left: 16.0.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.sp),
                        borderSide: const BorderSide(
                          color: Color(0xff435A39),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.sp),
                        borderSide: const BorderSide(
                          color: Color(0xff435A39),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                    ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffFEA900), // Background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.sp), // Same radius as TextFormField
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 16.h), // Adjust button height
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 20 / 14,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                  // SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 16.0.w, // Adjust size of the rounded checkbox
                        height: 16.0.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200, // Background color
                          borderRadius: BorderRadius.circular(100.sp),
                        ),
                        child: Transform.scale(
                          scale: 1, // Adjust the size of the checkbox
                          child: Checkbox(
                            value: context.watch<LoginProvider>().rememberMe,
                            onChanged: (value) {
                              context.read<LoginProvider>().toggleRememberMe(value);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.sp), // Round the checkbox itself
                            ),
                            activeColor: Colors.green, // Customize active color
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Remember me',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans-Regular',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 15.12 / 12,
                            color: Color(0xff667085),
                          ),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w500,
                            height: 15.12 / 12.0, // Line height calculation
                            letterSpacing: -0.01.sp,
                            color: Color(0xff435A39), // Text color for contrast with background
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],)
                ),
              ),
              SizedBox(height: 12.h),
              // Padding(
              //   padding: const EdgeInsets.all(18),
              //   child: Container(
              //     height: screenHeight * 202/812.h,
              //     width: screenWidth * 339/375.w,
              //     // color: Colors.amberAccent,
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 48.h,
              //           // width: screenWidth * 339/375.w,
              //           // color: Colors.pink,
              //       child: TextFormField(
              //         controller: _emailController,
              //         keyboardType: TextInputType.emailAddress,
              //         decoration: InputDecoration(
              //           labelText: 'Email',
              //           labelStyle: TextStyle(
              //             color: Color(0xff435A39),
              //             fontFamily: 'PlusJakartaSans-Regular',
              //             fontSize: 14.sp,
              //             fontWeight: FontWeight.w400,
              //             height: 17.64 / 14,
              //           ),// Added label text
              //           hintText: 'user@mail.com',
              //           hintStyle: TextStyle(
              //             color: Color(0xff171717),
              //             fontFamily: 'PlusJakartaSans-Regular',
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w400,
              //             height: 20.16 / 16,
              //           ),
              //           contentPadding: EdgeInsets.only(left: 16.0.w),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(100.sp),
              //             borderSide: BorderSide(
              //               color: Color(0xff435A39),
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(100.sp),
              //             borderSide: BorderSide(
              //               color: Color(0xff435A39),
              //               width: 1,
              //             ),
              //           ),
              //         ),
              //         ),
              //         ),
              //         SizedBox(height: 12.h),
              //
              //         Container(
              //           height: screenHeight * 48/812.h,
              //           width: screenWidth * 339/375.w,
              //           // color: Colors.pink,
              //           child: TextFormField(
              //             controller: _passwordController,
              //             obscureText: true,
              //             decoration: InputDecoration(
              //               labelText: 'Password',
              //               labelStyle: TextStyle(
              //                 color: Color(0xff435A39),
              //                 fontFamily: 'PlusJakartaSans-Regular',
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w400,
              //                 height: 17.64 / 14,
              //               ),// Added label text
              //               hintText: 'Password',
              //               hintStyle: TextStyle(
              //                 color: Color(0xff171717),
              //                 fontFamily: 'PlusJakartaSans-Regular',
              //                 fontSize: 16.sp,
              //                 fontWeight: FontWeight.w400,
              //                 height: 20.16 / 16,
              //               ),
              //               suffixIcon: IconButton(
              //                 icon: Icon(Icons.visibility),
              //                 onPressed: () {
              //                 },
              //               ),
              //               contentPadding: EdgeInsets.only(left: 16.0.w),
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(100.sp),
              //                 borderSide: BorderSide(
              //                   color: Color(0xff435A39),
              //                 ),
              //               ),
              //               focusedBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(100.sp),
              //                 borderSide: BorderSide(
              //                   color: Color(0xff435A39),
              //                   width: 1,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 12.h),
              //         Container(
              //           height: screenHeight * 48/812.h,
              //           width: screenWidth * 339/375.w,
              //           // color: Colors.pink,
              //           child: ElevatedButton(
              //             onPressed: _login,
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor: Color(0xffFEA900), // Background color
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(100.sp), // Same radius as TextFormField
              //               ),
              //               padding: EdgeInsets.symmetric(vertical: 16.h), // Adjust button height
              //             ),
              //             child: Center(
              //               child: Text(
              //                 'Sign In',
              //                 style: TextStyle(
              //                   fontFamily: 'Plus Jakarta Sans',
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                   height: 20 / 14,
              //                   color: Color(0xffFFFFFF),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 12.h),
              //
              //     Container(
              //       height: screenHeight * 16/812.h,
              //       width: screenWidth * 339/375.w,
              //       // color: Colors.pink,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             height: screenHeight * 16/812.h,
              //             width: screenWidth * 104/375.w,
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Container(
              //                   width: 16.0.w, // Adjust size of the rounded checkbox
              //                   height: 16.0.h,
              //                   decoration: BoxDecoration(
              //                     color: Colors.grey.shade200, // Background color
              //                     borderRadius: BorderRadius.circular(100.sp),
              //                   ),
              //                   child: Transform.scale(
              //                     scale: 1, // Adjust the size of the checkbox
              //                     child: Checkbox(
              //                       value: context.watch<LoginProvider>().rememberMe,
              //                       onChanged: (value) {
              //                         context.read<LoginProvider>().toggleRememberMe(value);
              //                       },
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(100.sp), // Round the checkbox itself
              //                       ),
              //                       activeColor: Colors.green, // Customize active color
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   'Remember me',
              //                   style: TextStyle(
              //                     fontFamily: 'PlusJakartaSans-Regular',
              //                     fontSize: 12.sp,
              //                     fontWeight: FontWeight.w400,
              //                     height: 15.12 / 12,
              //                     color: Color(0xff667085),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //
              //           TextButton(
              //             onPressed: () {
              //               // Handle forgot password
              //             },
              //             style: TextButton.styleFrom(
              //               padding: EdgeInsets.zero,
              //             ),
              //             child: Text(
              //               'Forgot password',
              //               style: TextStyle(
              //                 fontFamily: 'Plus Jakarta Sans',
              //                 fontSize: 12.0.sp,
              //                 fontWeight: FontWeight.w500,
              //                 height: 15.12 / 12.0, // Line height calculation
              //                 letterSpacing: -0.01.sp,
              //                 color: Color(0xff435A39), // Text color for contrast with background
              //                 textBaseline: TextBaseline.alphabetic,
              //               ),
              //               textAlign: TextAlign.right,
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: screenHeight * 39/812.h),
              Container(
                height: screenHeight * 213 / 812.h,
                width: screenWidth * 185 / 375.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pineapple.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 24/812.h),
              Text(
                _message,
                style: TextStyle(
                  color: _message.contains('successful') ? Colors.green : Colors.red, // Green for success, red for failure
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
          ),
        ),
      ),
    );
  }
}