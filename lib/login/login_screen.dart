import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cahaya/helper/decpty.dart';
import 'package:cahaya/login/app_colors.dart';
import 'package:cahaya/login/app_icons.dart';
import 'package:cahaya/login/app_styles.dart';
import 'package:cahaya/login/responsive_widget.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = true;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String _userControler = '';
  String _passwordControler = '';
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(
                    horizontal: ResponsiveWidget.isSmallScreen(context)
                        ? height * 0.032
                        : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.1),
                      Image.asset('images/title.png'),
                      SizedBox(height: height * 0.1),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Halaman',
                                style: ralewayStyle.copyWith(
                                  fontSize: 25.0,
                                  color: AppColors.blueDarkColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Log in ',
                              style: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueDarkColor,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Masukan Username dan Password',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          'Username',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            _userControler = val;
                          },
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SizedBox(
                             
                              child: Image.asset(AppIcons.emailIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 0),
                            hintText: 'Enter Username',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          'Password',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          onChanged: (val) {
                            _passwordControler = val;
                          },
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: hidden,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                hidden = !hidden;
                                setState(() {});
                              },
                              icon: hidden
                                  ? Image.asset(AppIcons.eyeIcon)
                                  : const Icon(Icons.remove_red_eye_rounded),
                            ),
                            prefixIcon: SizedBox(
                              child: Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 0),
                            hintText: 'Enter Password',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(height: height * 0.05),
                      RoundedLoadingButton(
                        color: Colors.green,
                        controller: _btnController,
                        successColor: Colors.green,
                        errorColor: Colors.red,
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool valid = false;
                          User? data;
                          List<User>? users = await Service.getUser();

                          if (users == null) {
                            return;
                          }
                          for (var element in users) {
                            //print(generateMd5(_passwordControler));
                            //print(element.password);
                            if (element.username == _userControler &&
                                element.password == _passwordControler) {
                              valid = true;
                              data = element;
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => MyHomePage(title: ''),));
                            }
                          }
                          if (valid) {
                            _btnController.success();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            await prefs.setString(
                                'data', jsonEncode(User.toMap(data!)));
                            Provider.of<ProviderData>(context, listen: false)
                                .login();
                            if (data.owner) {
                              //print('owner');
                              Provider.of<ProviderData>(context, listen: false)
                                  .owner();
                            } else {
                              //print('admin');
                              Provider.of<ProviderData>(context, listen: false)
                                  .admin();
                            }
                            return;
                          } else {
                            _btnController.error();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text('Username / Password Salah')));
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            _btnController.reset();
                            return;
                          }
                        },
                        child: const Text('Log in',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ResponsiveWidget.isSmallScreen(context)
                ? const SizedBox()
                : Expanded(
                    child: Container(
                      height: height,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Container(
                            child: Image.asset(
                          'images/cahaya.png',
                          height: height * 0.5,
                        )),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
